class Api::V1::RevenueController < ApplicationController
  def index
    if start_date_and_end_date_missing? || start_date_or_end_date_missing?
      json_response(ErrorMessage.between_dates_error, :bad_request)
    else
      revenue = Invoice.revenue_between_dates(params[:start], params[:end])
      json_response(RevenueSerializer.format_revenue(revenue))
    end
  end

  private

  def start_date_and_end_date_missing?
    !params[:start].present? && !params[:end].present?
  end

  def start_date_or_end_date_missing?
    params[:start].present? && !params[:end].present? || !params[:start].present? && params[:end].present?
  end
end
