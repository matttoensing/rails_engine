class Api::V1::Revenue::WeeklyController < ApplicationController
  def index
    invoices = Invoice.weekly_revenue
    json_response(WeeklyRevenueSerializer.format_json(invoices))
  end
end
