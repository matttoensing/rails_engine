class UnshippedRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attributes :potential_revenue do |invoice|
    invoice.revenue
  end
end
