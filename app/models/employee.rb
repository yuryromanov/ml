class Employee < ApplicationRecord
  belongs_to :department
  has_many :lunch_partners

  scope :available_for_lunch, -> { where(available_for_lunch: true) }

  def name
    "#{first_name} #{last_name}"
  end
end
