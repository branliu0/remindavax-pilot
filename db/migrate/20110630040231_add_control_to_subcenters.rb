class AddControlToSubcenters < ActiveRecord::Migration
  def self.up
    add_column :subcenters, :control, :boolean, :default => false
  end

  def self.down
    remove_column :subcenters, :control
  end
end
