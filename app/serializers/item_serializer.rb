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
end
