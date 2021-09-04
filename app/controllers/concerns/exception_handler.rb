module ExceptionHandler
  # provides the more graceful `included` method
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
end
