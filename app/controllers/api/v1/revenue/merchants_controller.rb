module Api
  module V1
    module Revenue
      class MerchantsController < ApplicationController
        def show
          merchant = Merchant.find(params[:id])
        end
      end
    end
  end
end
