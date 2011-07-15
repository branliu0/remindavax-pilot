class CronController < ApplicationController
  # This method should be called by a cron routine daily at 5AM IST, or
  # 11:30PM UTC/GMT
  #
  # It sends an SMS message to every single ANM with a list of the Taayi Card
  # numbers of all the patients that are due today. Also, the list of patients
  # that are over 3 days overdue are also sent.
  def anm_sms
    text = ""
    current_user.phc.anms.each do |anm|
      msg1, msg2 = generate_anm_message(anm)
      send_sms(anm.mobile, msg1)
      send_sms(anm.mobile, msg2)

      text += "#{anm.name}: messsage1 = #{msg1}, message2 = #{msg2}"
    end

    render :text => text
  end

  private
    def generate_anm_message(anm)
      message1 = "Patients Today: "
      patients_today = anm.patients_due_today
      message1 += (patients_today.size > 0) ? patients_today.map(&:taayi_card_number).join(',') : "None"

      message2 = "Patients Overdue: "
      appts_overdue = anm.find_appointments_by_date(:before => 2.days.ago.to_date) # more than 3 days ago
      message2 += (appts_overdue.size > 0) ? appts_overdue.map(&:patient).map(&:taayi_card_number).join(',') : "None"

      [message1, message2]
    end
end
