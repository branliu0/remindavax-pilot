# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

AppointmentType.delete_all
AppointmentType.create([
  { :appointment_type_id => 1, :name => "1st ANC and TT"                         , :message => "Please come to hospital for checkup and TT injection." },
  { :appointment_type_id => 2, :name => "2nd ANC"                                , :message => "Please come to hospital for checkup." },
  { :appointment_type_id => 3, :name => "3nd ANC"                                , :message => "Please come to hospital for checkup." },
  { :appointment_type_id => 4, :name => "Delivery, BCG, Polio 1 injection"       , :message => "Please come for delivery and baby's injection." },
  { :appointment_type_id => 5, :name => "DPT 1, Polio 2, Hepatitis B 1 injection", :message => "Please bring baby for injection." },
  { :appointment_type_id => 6, :name => "DPT 2, Polio 3, Hepatitis B 2 injection", :message => "Please bring baby for injection." },
  { :appointment_type_id => 7, :name => "DPT 3, Polio 4, Hepatitis B 3 injection", :message => "Please bring baby for injection." },
  { :appointment_type_id => 8, :name => "Measles"                                 , :message => "Please bring baby for injection." }
])
