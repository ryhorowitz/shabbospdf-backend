# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before reading this file.
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
set :job_template, "/Users/rywitz/.local/share/mise/installs/ruby/3.4.4/bin/bundler exec :job"

# Set the environment
set :environment, ENV['RAILS_ENV'] || 'development'

# Set the output log file
set :output, "log/cron.log"

# Run the weekly email job every Friday at 6:00 AM
every :friday, at: '6:00 am' do
  runner "SendWeeklyEmailsJob.perform_later"
end 

# test cronjob
every 1.minute do
  runner "SendWeeklyEmailsJob.perform_later"
end 