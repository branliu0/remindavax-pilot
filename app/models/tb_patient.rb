class TbPatient < ActiveRecord::Base
  attr_accessible :name, :age, :sex, :address, :mobile, :village, :subcenter_id,
    :anm_id, :caste, :children_below_6, :education

  belongs_to :phc
  validates :phc, :presence => true
  belongs_to :subcenter
  validates :subcenter, :presence => true
  belongs_to :anm
  validates :anm, :presence => true
  has_many :visits#, :dependent => :destroy
  has_many :appointments#, :dependent => :destroy
  has_many :sms
  
  belongs_to :subcenter
  belongs_to :anm

  validates :name, :presence => true
  validates :age, :presence => true, :numericality => true
  validates :sex, :presence => true
  enumerate :sex do
    value :name => 'male'
    value :name => 'female'
  end
  validates :address, :presence => true
  validates :mobile, :presence => true, :numericality => true
  validates_length_of :mobile, :is => 10 , :message => "should be 10 digits"
  validates :village, :presence => true
  validates :subcenter, :presence => true
  validates :anm, :presence => true
  validates :caste, :presence => true
  enumerate :caste do
    value :name => 'SC'
    value :name => 'ST'
    value :name => 'Other'
  end
  validates :children_below_6, :presence => true
  enumerate :children_below_6 do
    value :name => 'yes'
    value :name => 'no'
  end
  enumerate :education do
    value :name => 'Illiterate'
    value :name => 'Literate'
    value :name => 'Primary Education'
    value :name => 'High School'
    value :name => 'Degree'
    value :name => 'Other'
  end
  
  # Note: attr_encrypted _must_ go after enumerate (active_enum) in order to
  # work.
  attr_encrypted :age, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :sex, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :address, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :mobile, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :village, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :caste, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :children_below_6, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :education, :key => APP_CONFIG['encrypt_key']
  
  def self.search(phc, query)
    where('phc_id = ? AND name LIKE ?', phc, "%#{query}%")
  end

  def ongoing_treatments
    Treatment.where("tb_patient_id = ?", self).order("start_date ASC")
  end


  # This method should be called by a cron routine every Monday at 7:30AM IST, or
  # 2PM UTC/GMT, or 10PM EST
  def self.send_weekly_reminders(send = true)
    messages = ""
    all.each do |tb_patient|
      if () #check if this is a weekly reminder
        msg = tb_patient.sms_message
        SmsHelper::send_sms(tb_patient.mobile, msg) if send
        messages += "#{msg}\n"
      end
    end

    logger.info "TB Patient messages sent at #{Time.now}"
    logger.info messages
    messages
  end

  # This method should be called by a cron routine every Monday, Wednesday, and Friday
  # at 7:30AM IST, or 2PM UTC/GMT, or 10PM EST
  def self.send_triweekly_reminders(send = true)
    messages = ""
    #treatments.select {|t| t.startdate == Date.today }.any?

    all.each do |tb_patient|
      if () #check if this is a triweekly reminder
        msg = tb_patient.sms_message
        SmsHelper::send_sms(tb_patient.mobile, msg) if send
        messages += "#{msg}\n"
      end
    end

    logger.info "TB Patient messages sent at #{Time.now}"
    logger.info messages
    messages
  end

  def sms_message
    msg = "#{name}- Today: "

    today = find_appointments_by_date(:date => Date.today).map do |a|
      p = a.patient
      "#{p.name} for #{a.name}, #{p.taayi_card_number}"
    end.join("; ")

    msg += (today.empty?) ? "None" : today
    msg
  end


end
