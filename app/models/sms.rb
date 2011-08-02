# == Schema Information
# Schema version: 20110630040231
#
# Table name: sms
#
#  id             :integer(4)      not null, primary key
#  message        :string(255)
#  appointment_id :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

class Sms < ActiveRecord::Base
  attr_accessible :message

  belongs_to :appointment
  validates :appointment, :presence => true

  validates :message, :presence => true
end
