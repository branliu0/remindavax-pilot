class TreatmentType < ActiveRecord::Base
  # Used for select dropdowns
  # Creates a hash of name => treatment_type_id for each appointment!
  def self.names
    Hash[*all.collect { |a| [a.name, a.treatment_type_id] }.flatten]
  end
end
