class CreateAnms < ActiveRecord::Migration
  def self.up
    create_table :anms do |t|
      t.string :name
      t.string :mobile
      t.integer :phc_id

      t.timestamps
    end
  end

  def self.down
    drop_table :anms
  end
end
