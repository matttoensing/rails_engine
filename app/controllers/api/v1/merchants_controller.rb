class Api::V1::MerchantsController < ApplicationController
  def index
    if params[:per_page].present? && !params[:page].present?
      merchants = Merchant.paginate(:page => nil, :per_page => params[:per_page])
      json_response(MerchantSerializer.new(merchants))
    elsif params[:page].to_i <= 0
      merchants = Merchant.paginate(:page => 1, :per_page => 20)
      json_response(MerchantSerializer.new(merchants))
    else
      merchants = Merchant.paginate(:page => params[:page], :per_page => 20)
      json_response(MerchantSerializer.new(merchants))
    end
  end

  def show
    json_response(MerchantSerializer.new(Merchant.find(params[:id])))
  end
end
