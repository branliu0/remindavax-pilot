class AppointmentType < ActiveRecord::Base
  # Used for select dropdowns
  # Creates a hash of name => appt_type_id for each appointment!
  def self.names
    Hash[*all.collect { |a| [a.name, a.appointment_type_id] }.flatten]
  end

  def full_message
    name + "     " + message
  end
end
