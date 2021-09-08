class Api::V1::Revenue::MerchantsController < ApplicationController

  def index
    if !params[:quantity].present?
      json_response(MerchantRevenueSerializer.merchants_top_revenue_error, 400)
    elsif params[:quantity].present? && params[:quantity].to_i == 0
      json_response(MerchantRevenueSerializer.merchants_top_revenue_error, 400)
    elsif params[:quantity].to_i > 100
      merchant_count = Merchant.count
      merchants = Merchant.merchants_with_most_revenue(merchant_count)
      json_response(MerchantRevenueSerializer.format_top_revenue(merchants), 200)
    else
      merchants = Merchant.merchants_with_most_revenue(params['quantity'])
      json_response(MerchantRevenueSerializer.format_top_revenue(merchants), 200)
    end
  end

  def show
    merchant = Merchant.find(params[:id])
    json_response(MerchantRevenueSerializer.new(merchant))
  end
end
