require 'active_model/validator'

class IsJsonValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    @json = MultiJson.load(value, symbolize_keys: true)
    record.errors.add(attribute, "is empty") if @json.empty?
  rescue TypeError => e
    record.errors.add(attribute, "is not valid JSON: #{e.message}")
  rescue JSON::JSONError => e
    record.errors.add(attribute, "is not valid JSON: #{e.message}")
  end
end