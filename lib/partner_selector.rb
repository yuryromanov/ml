class PartnerSelector
  attr_reader :employees, :pairs, :history

  def initialize(employees, departments, history)
    @employees = employees.clone
    @departments = departments || []
    @history = HistoryChecker.new(history)
    @pairs = []
  end

  def perform
    generate_partners
  end

  private

  def generate_partners
    (0..pair_count).map do |index|
      partner1 = employees.shift
      partner2 = employees.detect { |id2| history.none?(partner1, id2) }
      employees.delete(partner2)

      if index.eql?(pair_count) && employees.present?
        [partner1, partner2, employees.last].compact
      else
        [partner1, partner2]
      end
    end
  end

  def pair_count
    @pair_count ||= (@employees.length / 2) - 1
  end
end
