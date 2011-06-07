class CreatePhcs < ActiveRecord::Migration
  def self.up
    create_table :phcs do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :phcs
  end
end
