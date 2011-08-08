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

  def self.creation_stats_by_week(phc_id)
    joins(:patient)
      .select("COUNT(1) as count, YEARWEEK(visits.created_at, 1) as yrwk, YEAR(visits.created_at) as year, WEEK(visits.created_at, 1) as week")
      .where("patients.phc_id = ?", phc_id)
      .group("yrwk")
      .order("yrwk DESC")
  end
end
