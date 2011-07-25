class Sms < ActiveRecord::Base
  attr_accessible :message

  belongs_to :appointment
  validates :appointment, :presence => true

  validates :message, :presence => true
end
