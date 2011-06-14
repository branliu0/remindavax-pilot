class ChangeApptDescToApptType < ActiveRecord::Migration
  def self.up
    remove_column :appointments, :description
    add_column :appointments, :appointment_type_id, :integer
  end

  def self.down
    add_column :appointments, :description, :string
    remove_column :appointments, :appointment_type_id
  end
end
