class LunchDate < ApplicationRecord
  has_many :mystery_lunches

  scope :upcoming, -> { order(date: :desc) }

  scope :last_3_months, -> (current_date = nil) do
    current_date ||= Date.current
    where(arel_table[:date].lt(current_date).and(arel_table[:date].gteq(current_date.beginning_of_month - 3.months)))
  end
end
