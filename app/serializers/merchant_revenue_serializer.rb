class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attributes :revenue do |merchant|
    merchant.revenue
  end

  def self.merchants_top_revenue_error
    {
      "message": "request could not be complete",
      "error": "quantity must be present"
    }
  end

  def self.top_revenue(merchants)
    merchants.map do |merchant|
      [id: merchant.id.to_s,
      type: 'merchant_name_revenue',
      attributes:
      { name: merchant.name,
        revenue: merchant.revenue }]
    end
  end

  def self.format_top_revenue(merchants)
    { data: top_revenue(merchants).flatten}
  end
end
