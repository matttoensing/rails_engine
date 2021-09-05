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

  def merchants_error_message
    { "data": [
      # "message": "your search could not be completed",
    ]
  }
end

def items_error_message(search)
  { "data": {
    "message": "your search could not be completed",
    "errors": [
      "#{search} yielded zero results"
    ]
  }
}
end

def items_update_error
  { "data": {
    "message": "update could not be completed",
    "errors": [
      "merchant does not exist"
    ]
  }
  }
  end
end
