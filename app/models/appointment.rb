# == Schema Information
# Schema version: 20110610034250
#
# Table name: appointments
#
#  id          :integer         not null, primary key
#  patient_id  :integer
#  date        :date
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Appointment < ActiveRecord::Base
  attr_accessible :date, :appointment_type_id
  belongs_to :patient
  belongs_to :appointment_type, :primary_key => :appointment_type_id

  validates :patient_id, :presence => true
  validates :appointment_type, :presence => true
  validates :date, :presence => true

  def name
    appointment_type.name[1..-2]
  end
end
