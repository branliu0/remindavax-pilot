class CreateSubcenters < ActiveRecord::Migration
  def self.up
    create_table :subcenters do |t|
      t.string :name
      t.integer :phc_id

      t.timestamps
    end
  end

  def self.down
    drop_table :subcenters
  end
end
