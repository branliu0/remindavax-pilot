class AddEncryptedSubcenterToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :encrypted_subcenter, :string
  end

  def self.down
    remove_column :patients, :encrypted_subcenter
  end
end
