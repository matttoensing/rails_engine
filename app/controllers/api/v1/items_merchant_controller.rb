class Api::V1::ItemsMerchantController < ApplicationController
  def show
    item = Item.find(params[:item_id])
    json_response(MerchantSerializer.new(item.merchant))
  end
end
