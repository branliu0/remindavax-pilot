class Anm < ActiveRecord::Base
  attr_accessible :name, :mobile

  belongs_to :phc
  validates :phc_id, :presence => true
  has_many :patients

  validates :name, :presence => true
  validates :mobile, :presence => true, :numericality => true
  validates_length_of :mobile, :is => 10, :message => "should be 10 digits"
end
