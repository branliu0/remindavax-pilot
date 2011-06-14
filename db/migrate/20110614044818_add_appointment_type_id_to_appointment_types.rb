class AddAppointmentTypeIdToAppointmentTypes < ActiveRecord::Migration
  def self.up
    add_column :appointment_types, :appointment_type_id, :integer
  end

  def self.down
    remove_column :appointment_types, :appointment_type_id
  end
end
