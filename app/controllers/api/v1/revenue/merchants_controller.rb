module Api
  module V1
    module Revenue
      class MerchantsController < ApplicationController
        def show
          merchant = Merchant.find(params[:id])
          render(json: MerchantRevenueSerializer.new(merchant))
        end
      end
    end
  end
end
