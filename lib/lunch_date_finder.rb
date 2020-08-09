class LunchDateFinder
  attr_reader :date

  def initialize(date)
    @date = date
  end

  def next_date
    new_date = (date + 1.month).beginning_of_month
    new_date += 1.day until new_date.wday > 1
    new_date
  end
end