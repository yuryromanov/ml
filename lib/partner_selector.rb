class PartnerSelector
  attr_reader :employees, :pairs, :history, :list_of_partners

  def initialize(employees, history)
    @employees = employees.clone
    @history = HistoryChecker.new(history)
    @pairs = []
  end

  def perform
    generate_partners
    fix_edge_cases
    list_of_partners
  end

  private

  def generate_partners
    @list_of_partners = (0..pair_count).map do |index|
      partner1 = employees.shift
      partner2 = employees.detect { |partner| history.none?(partner1.id, partner.id) }

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
      group = partners + [employees.last]
      departments = group.map(&:department_id).uniq
      different_departments = departments.count.eql?(group.count)

      if different_departments
        partners << employees.last
        break
      end
    end
  end

  def pair_count
    @pair_count ||= (employees.length / 2) - 1
  end
end
