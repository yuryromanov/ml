class MysteryLunch < ApplicationRecord
  belongs_to :lunch_date
  has_many :lunch_partners
end
