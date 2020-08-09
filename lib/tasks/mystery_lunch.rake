namespace :mystery_lunch do
  # per current implementation, task must be run daily.
  task create: :environment do
    date = LunchDateFinder.new(Date.current).next_date
    LunchCreator.new(date).perform
  end
end
