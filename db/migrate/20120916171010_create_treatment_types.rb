class CreateTreatmentTypes < ActiveRecord::Migration
  def self.up
    create_table :treatment_types do |t|
      t.string :name
      t.string :message
      t.string :frequency

      t.timestamps
    end
  end

  def self.down
    drop_table :treatment_types
  end
end
