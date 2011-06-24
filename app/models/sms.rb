class Sms < ActiveRecord::Base
  attr_accessible :message, :patient_id, :appointment_id

  belongs_to :patient
  validates :patient_id, :presence => true
  belongs_to :appointment
  validates :appointment_id, :presence => true

  validates :message, :presence => true
end
