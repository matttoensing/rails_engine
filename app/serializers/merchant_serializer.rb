class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  def self.merchant_id_string_error(attribute, id)
    { "error": "merchant could not be found with #{attribute}: #{id}"}
  end

  def self.merchants_error_message
    { "data": []}
  end
end
