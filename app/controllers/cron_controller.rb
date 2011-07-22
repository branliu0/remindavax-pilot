class CronController < ApplicationController
  def anm_sms
    render :inline => Anm.send_daily_reminders(false).gsub!(/\n/, "<br />")
  end
end
