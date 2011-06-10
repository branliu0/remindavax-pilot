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

# require "#{::Rails.root.to_s}/lib/validators/DateFormatValidator"

class Appointment < ActiveRecord::Base
  attr_accessible :date
  belongs_to :patient
  validates :patient_id, :presence => true

  validates :date, :presence => true # , :date_format => true
end
