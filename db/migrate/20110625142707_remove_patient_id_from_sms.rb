class RemovePatientIdFromSms < ActiveRecord::Migration
  def self.up
    remove_column :sms, :patient_id
  end

  def self.down
    add_column :sms, :patient_id, :integer
  end
end
