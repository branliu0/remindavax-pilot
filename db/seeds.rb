# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

AppointmentType.delete_all
AppointmentType.create([
  { :appointment_type_id => 1, :name => "1st ANC and TT"                         , :message => "Visit PHC/SC for checkup and TT injection on %date%" },
  { :appointment_type_id => 2, :name => "2nd ANC"                                , :message => "Visit PHC/SC for checkup on %date%" },
  { :appointment_type_id => 3, :name => "3nd ANC"                                , :message => "Visit PHC/SC for checkup on %date%" },
  { :appointment_type_id => 4, :name => "Delivery, BCG, Polio 1 injection"       , :message => "Visit %delivery_place% for delivery on %date%. Call 108 for emergency." },
  { :appointment_type_id => 5, :name => "DPT 1, Polio 2, Hepatitis B 1 injection", :message => "Visit PHC/SC/Anganwadi for immunization on %date%" },
  { :appointment_type_id => 6, :name => "DPT 2, Polio 3, Hepatitis B 2 injection", :message => "Visit PHC/SC/Anganwadi for immunization on %date%" },
  { :appointment_type_id => 7, :name => "DPT 3, Polio 4, Hepatitis B 3 injection", :message => "Visit PHC/SC/Anganwadi for immunization on %date%" },
  { :appointment_type_id => 8, :name => "Measles"                                 , :message => "Visit PHC/SC/Aganwadi for immunization on %date%" }
])
