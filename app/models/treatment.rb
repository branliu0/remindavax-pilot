class Treatment < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :treatment_type_id

  belongs_to :tb_patient
  belongs_to :treatment_type, :primary_key => :treatment_type_id
  #has_many :sms, :class_name => "Sms", :dependent => :destroy

  validates :patient, :presence => true
  validates :treatment_type, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true

  def name
    treatment_type.name
  end

  def message
    treatment_type.message.gsub(/%date%/, date_str).gsub(/%delivery_place%/, Patient::DeliveryPlace[patient.delivery_place.to_i] || "Undefined")
  end

  def date_str
    date.strftime("%d-%m-%Y")
  end

  def info
    "#{name} on #{date_str}"
  end

  def sms_message
    msg = "#{patient.name}: +#{name}+     #{message}"
    msg = "!!IMPORTANT!! " + msg if date < Date.today # Add a warning if this appt is overdue
    msg
  end

  def self.creation_stats_by_week(phc_id)
    joins(:patient)
    .select("COUNT(1) as count, YEARWEEK(appointments.created_at, 1) as yrwk, YEAR(appointments.created_at) as year, WEEK(appointments.created_at, 1) as week")
    .where("patients.phc_id = ?", phc_id)
    .group("yrwk")
    .order("yrwk DESC")
  end

end
