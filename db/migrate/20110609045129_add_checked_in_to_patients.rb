class AddCheckedInToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :checked_in, :boolean, :default => false
  end

  def self.down
    remove_column :patients, :checked_in
  end
end
