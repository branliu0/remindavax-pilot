# == Schema Information
# Schema version: 20110610043401
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
#  receiving_texts       :boolean
#

class Patient < ActiveRecord::Base
  attr_accessible :name, :mobile, :cell_access
  attr_encrypted :mobile, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :cell_access, :key => APP_CONFIG['encrypt_key']
  belongs_to :phc
  validates :phc_id, :presence => true
  has_many :visits, :dependent => :destroy, :order => "date DESC"
  has_many :appointments, :dependent => :destroy, :order => "date DESC"

  validates :name, :presence => true
  validates :mobile, :presence => true, :numericality => true
  validates_length_of :mobile, :is => 10 , :message => "should be 10 digits"
  validates :cell_access, :presence => true
  validates_inclusion_of :cell_access, :in => %w{yes no}

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
      Appointment.where("patient_id = ? AND date > ?", self, latest_visit.date).order("date DESC")
    else
      appointments
    end
  end

  private
  def randomize_receiving_texts
    # Randomly put this patient into control or experimental group
    self.receiving_texts = (rand(2) == 1) if new_record?
  end
end
