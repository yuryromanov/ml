class LunchUpdater
  def join_existing_lunch(employee)
    history = []
    partners = LunchPartnerSelector
      .new([employee], history, list_of_partners: list_of_partners)
      .join_to_existing_pair

    find_mystery_lunch(partners.first.id).lunch_partners.create(employee: employee)
  end

  def rearrange_lunch(employee)
    mystery_lunch = find_mystery_lunch(employee.id)

    mystery_lunch.lunch_partners.where(employee_id: employee.id).delete_all

    if mystery_lunch.lunch_partners.count.eql?(1)
      partner = mystery_lunch.lunch_partners.first.employee
      mystery_lunch.lunch_partners.delete_all

      join_existing_lunch(partner)
    end
  end

  private

  def upcoming
    LunchDate.upcoming.first
  end

  def mystery_lunch_ids
    upcoming.mystery_lunches.pluck(:id)
  end

  def list_of_partners
    result = {}
    LunchPartner
      .where(mystery_lunch_id: mystery_lunch_ids)
      .each do |lunch_partner|
        result[lunch_partner.mystery_lunch_id] ||= []
        result[lunch_partner.mystery_lunch_id] << lunch_partner.employee
      end
    result.values
  end

  def find_mystery_lunch(employee_id)
    LunchPartner
      .where(mystery_lunch_id: mystery_lunch_ids, employee_id: employee_id)
      .first
      .mystery_lunch
  end
end
