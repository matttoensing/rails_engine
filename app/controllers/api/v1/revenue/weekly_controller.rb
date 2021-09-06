module Api
  module V1
    module Revenue
      class WeeklyController < ApplicationController
        def index
          invoices = Invoice.weekly_revenue
          render(json: RevenueSerializer.format_json(invoices), status: 200)
        end
      end
    end
  end
end
