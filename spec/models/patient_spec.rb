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
