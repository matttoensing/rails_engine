module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        def index
          if params[:name] == ''
            json_response(merchant_id_string_error, 400)
          else
            merchants = Merchant.search_results(params[:name])
            if merchants.nil?
              json_response(merchants_error_message, 400)
            else
              json_response(MerchantSerializer.new(merchants))
            end
          end
        end
      end
    end
  end
end
