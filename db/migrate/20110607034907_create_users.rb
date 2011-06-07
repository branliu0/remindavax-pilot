class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :encrypted_password
      t.string :salt
      t.boolean :admin, :default => false
      t.integer :phc_id

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
