class Api::V1::MerchantsController < ApplicationController
  def index
    if per_page_present_only?
      merchants = Merchant.paginate(:page => nil, :per_page => params[:per_page])
      json_response(MerchantSerializer.new(merchants))
    elsif page_less_than_zero?
      merchants = Merchant.paginate(:page => 1, :per_page => 20)
      json_response(MerchantSerializer.new(merchants))
    else
      merchants = Merchant.paginate(:page => params[:page].to_i, :per_page => 20)
      json_response(MerchantSerializer.new(merchants))
    end
  end

  def show
    json_response(MerchantSerializer.new(Merchant.find(params[:id])))
  end

  private

  def per_page_present_only?
    params[:per_page].present? && !params[:page].present?
  end

  def page_less_than_zero?
    params[:page].to_i <= 0
  end
end
