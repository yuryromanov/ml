# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
# Learn more: http://github.com/javan/whenever

# “At 01:00 on day-of-month 1.”
# https://crontab.guru/#0_1_1_*_*
every '0 1 1 * *' do
  rake 'mystery_lunch:create'
end
