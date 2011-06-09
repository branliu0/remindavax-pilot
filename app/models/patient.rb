# == Schema Information
# Schema version: 20110607050222
#
# Table name: patients
#
#  id                    :integer         not null, primary key
#  name                  :string(255)
#  encrypted_mobile      :string(255)
#  encrypted_cell_access :string(255)
#  phc_id                :integer
#  created_at            :datetime
#  updated_at            :datetime
#

class Patient < ActiveRecord::Base
  attr_accessible :name, :mobile, :cell_access
  attr_encrypted :mobile, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :cell_access, :key => APP_CONFIG['encrypt_key']
  belongs_to :phc
  validates :phc_id, :presence => true

  validates :name, :presence => true
  validates :mobile, :presence => true, :numericality => true
  validates_length_of :mobile, :is => 10 , :message => "should be 10 digits"
  validates :cell_access, :presence => true
  validates_inclusion_of :cell_access, :in => %w{yes no}

  def self.search(query)
    where('name LIKE ?', "%#{query}%")
  end
end
