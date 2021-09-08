class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :unit_price, :merchant_id

  def self.missing_attributes_error
    { "data": { "message": "missing attributes"}}
  end

  def self.items_update_error
    { "data": {
      "message": "update could not be completed",
      "errors": [
        "merchant does not exist"
      ]
    }
  }
  end

  def self.items_error_message(search)
    { "data": {
      "message": "your search could not be completed",
      "errors": [
        "#{search} yielded zero results"
      ]
    }
  }
  end

  def self.item_min_price_search_error
    { "error": "no items meets this price"}
  end

  def self.item_min_price_too_big
    { "data": { "error": "no items meet this price"}}
  end
end
