class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.weekly_revenue
  joins(:invoice_items).group("DATE_TRUNC('week', invoices.created_at + interval '0.2523 day')").sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
