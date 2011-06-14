class AddNameToAppointmentTypes < ActiveRecord::Migration
  def self.up
    add_column :appointment_types, :name, :string
  end

  def self.down
    remove_column :appointment_types, :name
  end
end
