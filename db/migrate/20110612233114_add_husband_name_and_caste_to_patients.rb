class AddHusbandNameAndCasteToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :encrypted_husband_name, :string
    add_column :patients, :encrypted_caste, :string
  end

  def self.down
    remove_column :patients, :caste
    remove_column :patients, :husband_name
  end
end
