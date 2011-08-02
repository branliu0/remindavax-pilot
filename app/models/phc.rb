# == Schema Information
# Schema version: 20110630040231
#
# Table name: phcs
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Phc < ActiveRecord::Base
  has_many :users
  has_many :patients
  has_many :anms
  has_many :ashas
  has_many :subcenters

  validates :name, :presence => true

  def patients_due_today
    patients.select(&:appointment_today?)
  end

  def find_appointments_by_date(options)
    query = Appointment.includes(:patient).joins(:patient)
      .where("appointments.date > (SELECT MAX(date) FROM visits WHERE visits.patient_id = patients.id) OR (SELECT COUNT(1) FROM visits WHERE visits.patient_id = patients.id) = 0") # Ensure that 1) The latest visit was before the appointment OR 2) There have been no visits yet
      .where("patients.phc_id = ?", id)
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
