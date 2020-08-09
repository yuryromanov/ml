class Employee < ApplicationRecord
  belongs_to :department
  has_many :lunch_partners

  scope :available_for_lunch, -> { where(available_for_lunch: true) }

  validates :first_name, length: {maximum: 255}, allow_blank: false
  validates :last_name, length: {maximum: 255}, allow_blank: false
  validates :email, uniqueness: true
end
