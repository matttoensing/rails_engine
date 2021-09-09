class Api::V1::Revenue::WeeklyController < ApplicationController
  def index
    invoices = Invoice.weekly_revenue
    render(json: WeeklyRevenueSerializer.format_json(invoices), status: 200)
  end
end
