class Api::V1::Revenue::UnshippedController < ApplicationController
  def index
    if quantity_missing?
      json_response(UnshippedRevenueSerializer.unshipped_invoices_error, :bad_request)
    elsif quantity_is_string?
      json_response(UnshippedRevenueSerializer.unshipped_invoices_error, :bad_request)
    else
      invoices = Invoice.unshipped_revenue
      json_response(UnshippedRevenueSerializer.new(invoices))
    end
  end

  private

  def quantity_missing?
    params[:quantity] == ''
  end

  def quantity_is_string?
    params[:quantity].present? && params[:quantity].to_i.zero?
  end
end
