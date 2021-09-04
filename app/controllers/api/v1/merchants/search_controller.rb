module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        def index
          merchants = Merchant.search_results(params[:name])
          if merchants.nil?
            render(json: merchants_error_message, status: 400)
          else
            render(json: MerchantSerializer.new(merchants))
          end
        end
      end
    end
  end
end
