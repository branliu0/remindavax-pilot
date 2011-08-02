class AddAshaIdToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :asha_id, :integer
  end

  def self.down
    remove_column :patients, :asha_id
  end
end
