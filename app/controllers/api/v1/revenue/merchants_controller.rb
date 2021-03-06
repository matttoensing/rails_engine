class Api::V1::Revenue::MerchantsController < ApplicationController
  MERCHANT_COUNT = Merchant.count

  def index
    if missing_quantity? || quantity_is_a_string?
      json_response(ErrorMessage.merchants_top_revenue_error, :bad_request)
    elsif quantity_greater_than_merchant_count?
      merchants = Merchant.merchants_with_most_revenue(MERCHANT_COUNT)
      json_response(MerchantNameRevenueSerializer.new(merchants))
    else
      merchants = Merchant.merchants_with_most_revenue(params[:quantity].to_i)
      json_response(MerchantNameRevenueSerializer.new(merchants))
    end
  end

  def show
    merchant = Merchant.find(params[:id])
    json_response(MerchantRevenueSerializer.new(merchant))
  end

  private

  def missing_quantity?
    !params[:quantity].present?
  end

  def quantity_is_a_string?
    params[:quantity].to_i == 0
  end

  def quantity_greater_than_merchant_count?
    params[:quantity].to_i >= MERCHANT_COUNT
  end
end
