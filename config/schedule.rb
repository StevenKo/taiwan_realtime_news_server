# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

env :PATH, ENV['PATH']


every :day, :at => '07:00am,08:00am,09:00am,10:00am,11:00am,12:00am,01:00pm,02:00pm,03:00pm,04:00pm,05:00pm,06:00pm,07:00pm,08:00pm,09:00pm,10:00pm,11:00pm,12:00pm' do
  rake 'crawl:crawl_apple_news',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_free_news',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_union_news',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_chinatime_news',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_economy_news',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :day, :at => '07:10am,08:10am,09:10am,10:10am,11:10am,12:10am,01:10pm,02:10pm,03:10pm,04:10pm,05:10pm,06:10pm,07:10pm,08:10pm,09:10pm,10:10pm,11:10pm,12:10pm' do
  rake 'crawl:regenerate_drama_eps_str',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end