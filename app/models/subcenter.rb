# == Schema Information
# Schema version: 20110630040231
#
# Table name: subcenters
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  phc_id     :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  control    :boolean(1)
#

class Subcenter < ActiveRecord::Base
  attr_accessible :name, :phc_id, :control

  belongs_to :phc
  has_many :patients

  validates :name, :presence => true
  validates :phc, :presence => true
end
