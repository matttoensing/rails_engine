class Api::V1::Merchants::SearchController < ApplicationController
  def index
    if params[:name] == ''
      json_response(MerchantSerializer.merchant_id_string_error('name', params[:name]), 400)
    else
      merchants = Merchant.search_results(params[:name])
      return json_response(MerchantSerializer.merchants_error_message, 400) if merchants.nil?

      json_response(MerchantSerializer.new(merchants))
    end
  end
end
