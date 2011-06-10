class AddReceivingTextsToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :receiving_texts, :boolean
  end

  def self.down
    remove_column :patients, :receiving_texts
  end
end
