class Api::V1::MerchantItemsController < ApplicationController
  def index
    if merchant_id_a_string?
      json_response(ErrorMessage.merchant_id_string_error('id', params[:merchant_id]), :not_found)
    else
      merchant = Merchant.find(params[:merchant_id])
      json_response(ItemSerializer.new(merchant.items))
    end
  end

  private

  def merchant_id_a_string?
    params[:merchant_id].to_i.zero?
  end
end
