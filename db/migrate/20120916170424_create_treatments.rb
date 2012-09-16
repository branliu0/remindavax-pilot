class CreateTreatments < ActiveRecord::Migration
  def self.up
    create_table :treatments do |t|
      t.integer :treatment_type_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end

  def self.down
    drop_table :treatments
  end
end
