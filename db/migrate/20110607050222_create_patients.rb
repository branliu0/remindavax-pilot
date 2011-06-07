class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.string :name
      t.integer :mobile
      t.boolean :cell_access
      t.integer :phc_id

      t.timestamps
    end
  end

  def self.down
    drop_table :patients
  end
end
