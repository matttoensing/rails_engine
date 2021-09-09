class UnshippedRevenueSerializer
  def self.format_unshipped_invoices(invoices)
    { data: unshipped_invoices(invoices).flatten }
  end

  def self.unshipped_invoices(invoices)
    invoices.map do |invoice_id, revenue|
      [
        id: invoice_id.to_s,
        type: "unshipped_order",
        attributes: {
          potential_revenue: revenue
        }
      ]
    end
  end

  def self.unshipped_invoices_error
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
