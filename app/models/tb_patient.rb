class TbPatient < ActiveRecord::Base
  attr_accessible :name, :age, :sex, :address, :mobile, :village, :subcenter_id,
    :anm_id, :caste, :children_below_6, :education

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
  validates :mobile, :numericality => true, :if => Proc.new { |p| !p.mobile.blank? }
  validates_length_of :mobile, :is => 10 , :message => "should be 10 digits", :if => Proc.new { |p| !p.mobile.blank? }
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
  attr_encrypted :address, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :mobile, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :village, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :caste, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :children_below_6, :key => APP_CONFIG['encrypt_key']
  attr_encrypted :education, :key => APP_CONFIG['encrypt_key']
  

  
end
