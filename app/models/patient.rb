class Patient < ActiveRecord::Base
  attr_accessible :name, :mobile, :cell_access
  belongs_to :phc

  validates :name, :presence => true
  validates :mobile, :presence => true
  validates :cell_access, :presence => true
end
