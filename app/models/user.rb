# == Schema Information
# Schema version: 20110630040231
#
# Table name: users
#
#  id                 :integer(4)      not null, primary key
#  username           :string(255)
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean(1)
#  phc_id             :integer(4)
#  created_at         :datetime
#  updated_at         :datetime
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :username, :password, :password_confirmation, :admin, :phc_id
  belongs_to :phc
  validates :phc, :presence => true

  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true, :confirmation => true
  validates :password_confirmation, :presence => true

  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(username, submitted_password)
    user = find_by_username(username)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  private
  def encrypt_password
    self.salt = secure_hash("#{Time.now.utc}--#{password}") if new_record?
    self.encrypted_password = encrypt(password)
  end

  def secure_hash(text)
    Digest::SHA2.hexdigest(text)
  end

  def encrypt(text)
    secure_hash("#{salt}--#{text}")
  end
end
