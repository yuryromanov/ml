class LunchCreator
  attr_reader :date

  def initialize(date)
    @date = date || next_lunch_date
  end

  def perform
    lunch_date = LunchDate.create(date: date)

    list_of_partners.each do |partners|
      mystery_lunch = MysteryLunch.create(lunch_date: lunch_date)

      partners.each do |employee|
        mystery_lunch.lunch_partners.create(employee: employee)
      end
    end
  end

  private

  def next_lunch_date
    upcoming = LunchDate.upcoming.first
    LunchDateFinder.new(upcoming ? upcoming.lunch_date : Date.current).next_date
  end

  def list_of_partners
    LunchPartnerSelector.new(employees, history, shuffle: true).perform
  end

  def employees
    Employee.available_for_lunch.to_a
  end

  def history
    mystery_lunch_ids = MysteryLunch.joins(:lunch_date).merge(LunchDate.last_3_months(date)).pluck(:id)

    result = {}
    LunchPartner
      .where(mystery_lunch_id: mystery_lunch_ids)
      .each do |lunch_partner|
        result[lunch_partner.mystery_lunch_id] ||= []
        result[lunch_partner.mystery_lunch_id] << lunch_partner.employee_id
      end
    result.values
  end
end
