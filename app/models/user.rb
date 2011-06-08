# == Schema Information
# Schema version: 20110607050222
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  username           :string(255)
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean
#  phc_id             :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :username, :password, :password_confirmation, :admin
  belongs_to :phc

  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true, :confirmation => true
  validates :password_confirmation, :presence => true

  before_save :encrypt_password

  def self.authenticate(username, submitted_password)
    user = find_by_username(username)
    return nil if user.nil?
    return user if user.password == submitted_password
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  private
  def encrypt_password
    self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{password}") if new_record?
    self.encrypted_password = Digest::SHA2.hexdigest("#{salt}--#{password}")
  end
end
