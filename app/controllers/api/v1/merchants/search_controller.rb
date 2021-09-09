class Api::V1::Merchants::SearchController < ApplicationController
  def index
    if name_missing?
      json_response(MerchantSerializer.merchant_id_string_error('name', params[:name]), :bad_request)
    else
      merchants = Merchant.search_results(params[:name])
      return json_response(MerchantSerializer.merchants_error_message, :bad_request) if merchants.nil?

      json_response(MerchantSerializer.new(merchants))
    end
  end

  private

  def name_missing?
    params[:name] == ''
  end
end
