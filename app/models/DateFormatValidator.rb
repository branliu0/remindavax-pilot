class DateFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      Date.parse(value)
    rescue ArgumentError
      record.errors[attribute] << "Please enter a valid date"
    end
  end
end
