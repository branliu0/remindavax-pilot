# == Schema Information
# Schema version: 20110630040231
#
# Table name: anms
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  mobile     :string(255)
#  phc_id     :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Anm < ActiveRecord::Base
  attr_accessible :name, :mobile

  belongs_to :phc
  validates :phc, :presence => true
  has_many :patients

  validates :name, :presence => true
  validates :mobile, :presence => true, :numericality => true
  validates_length_of :mobile, :is => 10, :message => "should be 10 digits"

  # This method should be called by a cron routine daily at 7:30AM IST, or
  # 2PM UTC/GMT, or 10PM EST
  def self.send_daily_reminders(send = true)
    messages = ""
    all.each do |anm|
      msg = anm.sms_message
      SmsHelper::send_sms(anm.mobile, msg) if send

      messages += "#{msg}\n"
    end

    logger.info "ANM messages sent at #{Time.now}"
    logger.info messages
    messages
  end

  def sms_message
    msg = "#{name}- Today: "
    today = find_appointments_by_date(:date => Date.today).map do |a|
      p = a.patient
      "#{p.name} for #{a.name}, #{p.taayi_card_number}"
    end.join("; ")
    msg += (today.empty?) ? "None" : today

    msg += " -- Overdue: "
    # More than 3 days ago
    overdue = find_appointments_by_date(:before => 2.days.ago.to_date).map do |a|
      p = a.patient
      "#{p.name} for #{a.name}, #{p.taayi_card_number}"
    end.join("; ")
    msg += (overdue.empty?) ? "None" : overdue
    msg
  end

  def patients_due_today
    patients.select(&:appointment_today?)
  end

  def find_appointments_by_date(options)
    query = Appointment.includes(:patient).joins(:patient)
      .where("appointments.date > (SELECT MAX(date) FROM visits WHERE visits.patient_id = patients.id) OR (SELECT COUNT(1) FROM visits WHERE visits.patient_id = patients.id) = 0") # Ensure that 1) The latest visit was before the appointment OR 2) There have been no visits yet
      .where("patients.phc_id = ? AND patients.anm_id = ?", phc.id, id)
    if options[:date]
      query = query.where("appointments.date = ?", options[:date])
    end
    if options[:after]
      query = query.where("appointments.date > ?", options[:after])
    end
    if options[:before]
      query = query.where("appointments.date < ?", options[:before])
    end
    query
  end
end
