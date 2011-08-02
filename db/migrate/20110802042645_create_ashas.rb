class CreateAshas < ActiveRecord::Migration
  def self.up
    create_table :ashas do |t|
      t.string :name
      t.string :mobile
      t.integer :phc_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ashas
  end
end
