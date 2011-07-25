class Subcenter < ActiveRecord::Base
  attr_accessible :name, :phc_id, :control

  belongs_to :phc
  has_many :patients

  validates :name, :presence => true
  validates :phc, :presence => true
end
