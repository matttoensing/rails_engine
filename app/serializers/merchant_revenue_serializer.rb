class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attributes :revenue do |merchant|
    merchant.total_revenue
  end

  def self.merchants_top_revenue_error
    {
      "message": "request could not be complete",
      "error": "quantity must be present"
    }
  end
end
