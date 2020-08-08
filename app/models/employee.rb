class Employee < ApplicationRecord
  belongs_to :department

  def name
    "#{first_name} #{last_name}"
  end
end
