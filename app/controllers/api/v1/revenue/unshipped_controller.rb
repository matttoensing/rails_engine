class Api::V1::Revenue::UnshippedController < ApplicationController
  def index
    if !params[:quantity].present? && params[:quantity] == ""
      json_response(UnshippedRevenueSerializer.unshipped_invoices_error, 400)
    elsif params[:quantity].present? && params[:quantity].to_i.zero?
      json_response(UnshippedRevenueSerializer.unshipped_invoices_error, 400)
    else
      invoices = Invoice.unshipped_revenue
      json_response(UnshippedRevenueSerializer.new(invoices))
    end
  end
end
