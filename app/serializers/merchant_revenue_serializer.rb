class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :revenue do |o|
    o.total_revenue
  end
end
