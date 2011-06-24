class CreateSms < ActiveRecord::Migration
  def self.up
    create_table :sms do |t|
      t.string :message
      t.integer :patient_id
      t.integer :appointment_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sms
  end
end
