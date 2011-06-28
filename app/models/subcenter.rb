class Subcenter < ActiveRecord::Base
  attr_accessible :name, :phc_id

  belongs_to :phc
  has_many :patietns

  validates :name, :presence => true
  validates :phc_id, :presence => true
end
