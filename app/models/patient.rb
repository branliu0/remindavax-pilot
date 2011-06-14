# == Schema Information
# Schema version: 20110612041053
#
# Table name: patients
#
#  id                               :integer         not null, primary key
#  name                             :string(255)
#  encrypted_mobile                 :string(255)
#  encrypted_cell_access            :string(255)
#  phc_id                           :integer
#  created_at                       :datetime
#  updated_at                       :datetime
#  receiving_texts                  :boolean
#  encrypted_expected_delivery_date :string(255)
#

class Patient < ActiveRecord::Base
  attr_accessible :name, :husband_name, :mobile, :cell_access, :taayi_card_number, :expected_delivery_date, :caste
  attr_encrypted :husband_name, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :mobile, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :cell_access, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :taayi_card_number, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :expected_delivery_date, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :caste, :key => APP_CONFIG['encrypt_key']

  belongs_to :phc
  validates :phc_id, :presence => true
  has_many :visits, :dependent => :destroy, :order => "date ASC"
  has_many :appointments, :dependent => :destroy, :order => "date ASC"

  validates :name, :presence => true
  validates :mobile, :presence => true, :numericality => true
  validates_length_of :mobile, :is => 10 , :message => "should be 10 digits"
  validates :cell_access, :presence => true
  validates_inclusion_of :cell_access, :in => %w{yes no}
  validates :taayi_card_number, :numericality => true
  validates_length_of :taayi_card_number, :is => 7
  validates :expected_delivery_date, :presence => true
  validates :caste, :presence => true
  validates_inclusion_of :caste, :in => %w{SC ST Other}

  before_save :randomize_receiving_texts

  def self.search(phc, query)
    where('phc_id = ? AND name LIKE ?', phc, "%#{query}%")
  end

  def checked_in?
    latest_visit && latest_visit.date == Date.today
  end

  def latest_visit
    Visit.where("patient_id = ?", self).order("date DESC").first
  end

  def scheduled_appointments
    if latest_visit
      Appointment.where("patient_id = ? AND date > ?", self, latest_visit.date).order("date ASC")
    else
      appointments
    end
  end

  def next_appointment
    scheduled_appointments.first if not scheduled_appointments.nil?
  end

  private

  # Randomly put this patient into control or experimental group
  def randomize_receiving_texts
    self.receiving_texts = (rand(2) == 1) if new_record?
    return true # Apparently things break if this method doesn't return true
  end
end
