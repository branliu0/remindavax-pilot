# == Schema Information
# Schema version: 20110630040231
#
# Table name: appointment_types
#
#  id                  :integer(4)      not null, primary key
#  message             :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  name                :string(255)
#  appointment_type_id :integer(4)
#

class AppointmentType < ActiveRecord::Base
  # Used for select dropdowns
  # Creates a hash of name => appt_type_id for each appointment!
  def self.names
    Hash[*all.collect { |a| [a.name, a.appointment_type_id] }.flatten]
  end
end
