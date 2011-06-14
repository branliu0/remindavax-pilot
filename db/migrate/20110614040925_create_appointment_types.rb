class CreateAppointmentTypes < ActiveRecord::Migration
  def self.up
    create_table :appointment_types do |t|
      t.string :message

      t.timestamps
    end
  end

  def self.down
    drop_table :appointment_types
  end
end
