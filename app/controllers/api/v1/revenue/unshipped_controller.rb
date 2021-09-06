module Api
  module V1
    module Revenue
      class UnshippedController < ApplicationController
        def index
          if !params[:quantity].present? && params[:quantity] == ""
            json_response(json: unshipped_invoices_error, status: 400)
          elsif params[:quantity].present? && params[:quantity].to_i.zero?
            json_response(json: unshipped_invoices_error, status: 400)
          else
            invoices = Invoice.unshipped_revenue
            render(json: RevenueSerializer.format_unshipped_invoices(invoices))
          end
        end
      end
    end
  end
end