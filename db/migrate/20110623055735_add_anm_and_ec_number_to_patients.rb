class AddAnmAndEcNumberToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :anm_id, :integer
    add_column :patients, :encrypted_ec_number, :string
  end

  def self.down
    remove_column :patients, :encrypted_ec_number
    remove_column :patients, :anm_id
  end
end
