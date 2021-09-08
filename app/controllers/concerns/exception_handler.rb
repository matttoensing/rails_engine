module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
  end

  def object_not_found_error(id)
    { "message": "Couldn't find Merchant with 'id': #{id}"}
  end

  def unshipped_invoices_error
    { "data": {
      "message": "request could not be completed",
      "code": 400,
      "errors": [
        "wrong data type does not exist",
      ]
    }
    }
  end
end
