class Api::V1::Revenue::MerchantsController < ApplicationController

  MERCHANT_COUNT = Merchant.count

  def index
    if missing_quantity?
      json_response(MerchantNameRevenueSerializer.merchants_top_revenue_error, :bad_request)
    elsif quanity_is_a_string?
      json_response(MerchantNameRevenueSerializer.merchants_top_revenue_error, :bad_request)
    elsif quantity_greater_than_merchant_count?
      merchants = Merchant.merchants_with_most_revenue(MERCHANT_COUNT)
      json_response(MerchantNameRevenueSerializer.new(merchants))
    else
      merchants = Merchant.merchants_with_most_revenue(params[:quantity])
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

  def quanity_is_a_string?
    params[:quantity].present? && params[:quantity].to_i == 0
  end

  def quantity_greater_than_merchant_count?
    params[:quantity].to_i >= MERCHANT_COUNT
  end
end
