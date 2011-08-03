# == Schema Information
# Schema version: 20110630040231
#
# Table name: appointments
#
#  id                  :integer(4)      not null, primary key
#  patient_id          :integer(4)
#  date                :date
#  created_at          :datetime
#  updated_at          :datetime
#  appointment_type_id :integer(4)
#

class Appointment < ActiveRecord::Base
  attr_accessible :date, :appointment_type_id

  belongs_to :patient
  belongs_to :appointment_type, :primary_key => :appointment_type_id
  has_many :sms, :class_name => "Sms", :dependent => :destroy

  validates :patient, :presence => true
  validates :appointment_type, :presence => true
  validates :date, :presence => true

  def name
    appointment_type.name
  end

  def message
    appointment_type.message.gsub(/%date%/, date_str).gsub(/%delivery_place%/, Patient::DeliveryPlace[patient.delivery_place.to_i] || "Undefined")
  end

  def date_str
    date.strftime("%d-%m-%Y")
  end

  def info
    "#{name} on #{date_str}"
  end

  def sms_message
    msg = "#{patient.name}: +#{name}+     #{message}"
    msg = "!!IMPORTANT!! " + msg if date < Date.today # Add a warning if this appt is overdue
    msg
  end
end
