class Api::V1::MerchantItemsController < ApplicationController
  def index
    if params[:merchant_id].to_i.zero?
      json_response(merchant_id_string_error, 404)
    else
      merchant = Merchant.find(params[:merchant_id])
      json_response(ItemSerializer.new(merchant.items))
    end
  end
end
