class AddEncryptedVillageToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :encrypted_village, :string
  end

  def self.down
    remove_column :patients, :encrypted_village
  end
end
