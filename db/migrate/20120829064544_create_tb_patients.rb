class CreateTbPatients < ActiveRecord::Migration
  def self.up
    create_table :tb_patients do |t|
      t.string :name
      t.integer :phc_id
      t.string :encrypted_age
      t.string :encrypted_sex
      t.string :encrypted_address
      t.string :encrypted_mobile
      t.string :encrypted_village
      t.integer :subcenter_id
      t.integer :anm_id
      t.string :encrypted_caste
      t.string :encrypted_children_below_6
      t.string :encrypted_education

      t.timestamps
    end
  end

  def self.down
    drop_table :tb_patients
  end
end
