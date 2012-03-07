class AddAbortionToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :abortion, :boolean
  end

  def self.down
    remove_column :patients, :abortion
  end
end
