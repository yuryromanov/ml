# frozen_string_literal: true

FactoryBot.define do
  factory :lunch_date do
    date { Date.current }
  end
end
