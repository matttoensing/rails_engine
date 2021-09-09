class Api::V1::RevenueController < ApplicationController
  def index
    revenue = Invoice.revenue_between_dates(params[:start], params[:end])
    json_response(RevenueSerializer.format_revenue(revenue))
  end
end
