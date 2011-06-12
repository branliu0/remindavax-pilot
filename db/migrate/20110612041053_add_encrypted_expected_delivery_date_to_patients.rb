class AddEncryptedExpectedDeliveryDateToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :encrypted_expected_delivery_date, :string
  end

  def self.down
    remove_column :patients, :encrypted_expected_delivery_date
  end
end
