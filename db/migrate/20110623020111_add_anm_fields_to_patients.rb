class AddAnmFieldsToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :encrypted_mother_age, :string
    add_column :patients, :encrypted_education, :string
    add_column :patients, :encrypted_delivery_place, :string
  end

  def self.down
    remove_column :patients, :encrypted_delivery_place
    remove_column :patients, :encrypted_education
    remove_column :patients, :encrypted_mother_age
  end
end
