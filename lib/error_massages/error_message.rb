class ErrorMessage
  def self.missing_attributes_error
    { "data": { "message": 'missing attributes' } }
  end

  def self.items_error_message(search)
    { "data": {
      "message": 'your search could not be completed',
      "errors": [
        "#{search} yielded zero results"
      ]
    } }
  end

  def self.item_min_price_search_error
    { "error": 'no items meets this price' }
  end

  def self.item_min_price_too_big
    { "data": { "error": 'no items meet this price' } }
  end

  def self.merchants_top_revenue_error
    {
      "message": 'request could not be complete',
      "error": 'quantity must be present'
    }
  end

  def self.merchant_id_string_error(attribute, id)
    { "error": "merchant could not be found with #{attribute}: #{id}" }
  end

  def self.merchants_error_message
    { "data": [] }
  end

  def self.unshipped_invoices_error
    { "data": {
      "message": 'request could not be completed',
      "errors": [
        'wrong data type does not exist'
      ]
    } }
  end

  def self.wrong_item_params_error
    {
      "message": 'request could not be complete',
      "error": 'params must be present'
    }
  end

  def self.min_price_greater_than_max_price
    {
      "message": 'request could not be complete',
      "error": 'min price cannot be greater than max price'
    }
  end
end
