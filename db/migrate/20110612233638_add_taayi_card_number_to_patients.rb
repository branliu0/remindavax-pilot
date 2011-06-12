class AddTaayiCardNumberToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :encrypted_taayi_card_number, :string
  end

  def self.down
    remove_column :patients, :encrypted_taayi_card_number
  end
end
