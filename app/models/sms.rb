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

  def self.creation_stats_by_week(phc_id)
    joins(:appointment => :patient)
      .select("COUNT(1) as count, YEARWEEK(sms.created_at, 1) as yrwk, YEAR(sms.created_at) as year, WEEK(sms.created_at, 1) as week")
      .where("patients.phc_id = ?", phc_id)
      .group("yrwk")
      .order("yrwk DESC")
  end
end
