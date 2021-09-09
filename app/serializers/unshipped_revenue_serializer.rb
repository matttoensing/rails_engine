class UnshippedRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attributes :potential_revenue do |invoice|
    invoice.revenue
  end

  def self.unshipped_invoices_error
    { "data": {
      "message": "request could not be completed",
      "code": 400,
      "errors": [
        "wrong data type does not exist"]}}
  end
end
