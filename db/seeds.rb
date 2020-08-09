# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  email = 'admin@example.com'
  if AdminUser.find_by(email: email).blank?
    AdminUser.create!(email: email, password: 'PASS11111', password_confirmation: 'PASS11111')
  end

  # create departments
  ['Sales', 'Marketing', 'Risk', 'Management', 'Finance', 'HR', 'Development', 'Data'].each do |name|
    Department.create(name: name)
  end

  # create and add employees to deparments
  Department.all.each do |department|
    (1..(3 + rand(10))).each do |index|
      FactoryBot.create(:employee, department: department)
    end
  end

  begin_date = Date.current - 2.months
  (0..2).each do |index|
    date = LunchDateFinder.new(begin_date).next_date
    LunchCreator.new(date).perform

    begin_date += 1.month
  end
end
