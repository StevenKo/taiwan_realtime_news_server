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


every :day, :at => '07:00am,10:00am,02:00pm,05:00pm,08:00pm,10:00pm' do
  rake 'crawl:crawl_apple_news',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_free_news',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_union_news',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_chinatime_news',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_economy_news',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :day, :at => '07:10am,10:10am,02:10pm,05:10pm,08:10pm,10:10pm' do
  rake 'crawl:update_promote',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end