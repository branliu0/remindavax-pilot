class RemoveCheckedInFromPatients < ActiveRecord::Migration
  def self.up
    remove_column :patients, :checked_in
  end

  def self.down
    add_column :patients, :checked_in, :boolean, :default => false
  end
end
