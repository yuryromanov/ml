class LunchPartnerSelector
  attr_reader :employees, :list_of_partners, :history

  def initialize(employees, history, shuffle: false)
    if shuffle
      @employees = employees.clone.shuffle
    else
      departments = employees.map(&:department_id)
      @employees = employees.clone.sort do |a, b|
        departments.count(b.department_id) <=> departments.count(a.department_id)
      end
    end
    @history = HistoryChecker.new(history)
    @list_of_partners = []
  end

  def perform
    generate_list_of_partners
    fix_edge_cases
    list_of_partners
  end

  private

  def generate_list_of_partners
    @list_of_partners = (0..pair_count).map do
      partner1 = employees.shift
      partner2 = employees.detect do |partner|
        history.none?(partner1.id, partner.id) &&
          different_departments?([partner1, partner])
      end

      employees.push(partner1) && next if partner2.nil?
      employees.delete(partner2)

      [partner1, partner2]
    end.compact
  end

  def fix_edge_cases
    if employees.count.eql?(2)
      @list_of_partners << employees
    else
      join_to_existing_pair
    end if employees.present?
  end

  def join_to_existing_pair
    list_of_partners.each do |partners|
      if different_departments?(partners + [employees.last])
        partners << employees.last
        break
      end
    end
  end

  def different_departments?(partners)
    departments = partners.map(&:department_id).uniq
    departments.count.eql?(partners.count)
  end

  def pair_count
    (employees.length / 2) - 1
  end
end
