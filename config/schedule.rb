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

# This corresponds to 7:30AM IST
every :day, :at => "10pm" do
  runner "Anm.send_daily_reminders"
  runner "Asha.send_daily_reminders"
end

# every week
every :monday, :at => "10pm" do
  runner "TbPatient.send_weekly_reminders"
end

# every 3 days
every :monday, :at => "10pm" do
  runner "TbPatient.send_triweekly_reminders"
end
every :wednesday, :at => "10pm" do
  runner "TbPatient.send_triweekly_reminders"
end
every :friday, :at => "10pm" do
  runner "TbPatient.send_triweekly_reminders"
end
