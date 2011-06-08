# == Schema Information
# Schema version: 20110607050222
#
# Table name: patients
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  mobile      :integer
#  cell_access :boolean
#  phc_id      :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Patient < ActiveRecord::Base
  attr_accessible :name, :mobile, :cell_access
  belongs_to :phc
  validates :phc_id, :presence => true

  validates :name, :presence => true
  validates :mobile, :presence => true, :numericality => true
  validates_length_of :mobile, :is => 10 , :message => "should be 10 digits"
  validates :cell_access, :presence => true

  around_create :encrypt_fields
  around_update :encrypt_fields
  around_save :encrypt_fields
  after_find :after_decrypt_fields


  private
  def encrypt_fields
    before_encrypt_fields
    yield
    after_decrypt_fields
  end

  def before_encrypt_fields
    APP_CONFIG['encrypt_key']
  end

  def after_decrypt_fields

  end
end
