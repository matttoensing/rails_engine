class Api::V1::Revenue::MerchantsController < ApplicationController

  def index
    if !params[:quantity].present?
      render(json: merchants_top_revenue_error, status: 400)
    elsif params[:quantity].present? && params[:quantity].to_i == 0
      render(json: merchants_top_revenue_error, status: 400)
    elsif params[:quantity].to_i > 100
      merchant_count = Merchant.count
      merchants = Merchant.merchants_with_most_revenue(merchant_count)
      render(json: RevenueSerializer.format_top_revenue(merchants), status: 200)
    else
      merchants = Merchant.merchants_with_most_revenue(params['quantity'])
      render(json: RevenueSerializer.format_top_revenue(merchants), status: 200)
    end
  end

  def show
    merchant = Merchant.find(params[:id])
    render(json: MerchantRevenueSerializer.new(merchant))
  end
end
