require 'spec_helper'

describe Patient do
  describe "encryption" do
    describe "around creating" do
      it "should keep the fields decrypted" do
        phc = Phc.create!(:name => "testphc")
        patient = phc.patients.create!(:name => "Brandon", :mobile => "1234567890", :cell_access => "yes")
        patient.name.should == "Brandon"
        patient.mobile.should == "1234567890"
        patient.cell_access.should == "yes"
        patient.phc.should == phc
      end
    end
    describe "around saving" do
      it "should keep the fields decrypted" do
        phc = Phc.create!(:name => "testphc")
        patient = phc.patients.build(:name => "Brandon", :mobile => "1234567890", :cell_access => "yes")
        patient.save
        patient.name.should == "Brandon"
        patient.mobile.should == "1234567890"
        patient.cell_access.should == "yes"
        patient.phc.should == phc
      end
    end

    describe "around updating" do
      it "should keep the fields decrypted" do
        phc = Phc.create!(:name => "testphc")
        patient = phc.patients.create!(:name => "Brandon", :mobile => "1234567890", :cell_access => "yes")
        patient.update_attributes!(:mobile => "0987654321", :cell_access => "no")
        patient.name.should == "Brandon"
        patient.mobile.should == "0987654321"
        patient.cell_access.should == "no"
        patient.phc.should == phc
      end
    end
  end
end

# == Schema Information
#
# Table name: patients
#
#  id                               :integer(4)      not null, primary key
#  name                             :string(255)
#  encrypted_mobile                 :string(255)
#  encrypted_cell_access            :string(255)
#  phc_id                           :integer(4)
#  created_at                       :datetime
#  updated_at                       :datetime
#  receiving_texts                  :boolean(1)
#  encrypted_expected_delivery_date :string(255)
#  encrypted_husband_name           :string(255)
#  encrypted_caste                  :string(255)
#  encrypted_taayi_card_number      :string(255)
#  encrypted_mother_age             :string(255)
#  encrypted_education              :string(255)
#  encrypted_delivery_place         :string(255)
#  anm_id                           :integer(4)
#  encrypted_ec_number              :string(255)
#  encrypted_village                :string(255)
#  subcenter_id                     :integer(4)
#  asha_id                          :integer(4)
#

