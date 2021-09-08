class Api::V1::Revenue::UnshippedController < ApplicationController
  def index
    if !params[:quantity].present? && params[:quantity] == ""
      json_response(unshipped_invoices_error, 400)
    elsif params[:quantity].present? && params[:quantity].to_i.zero?
      json_response(unshipped_invoices_error, 400)
    else
      invoices = Invoice.unshipped_revenue
      render(json: RevenueSerializer.format_unshipped_invoices(invoices))
    end
  end
end
