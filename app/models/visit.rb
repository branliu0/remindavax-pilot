# == Schema Information
# Schema version: 20110630040231
#
# Table name: visits
#
#  id          :integer(4)      not null, primary key
#  patient_id  :integer(4)
#  date        :date
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Visit < ActiveRecord::Base
  attr_accessible :date

  belongs_to :patient

  validates :patient, :presence => true
  validates :date, :presence => true
end
