class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  def self.weekly_revenue
  x = group("DATE_TRUNC('week', created_at)").sum('quantity * unit_price')
  end
end
