module Api
  module V1
    module Revenue
      class WeeklyController < ApplicationController
        def index
          invoices = Invoice.weekly_revenue
          render(json: RevenueSerializer.format_json(invoices))
        end
      end
    end
  end
end
