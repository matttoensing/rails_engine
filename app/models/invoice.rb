class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.weekly_revenue
    joins(:invoice_items).joins(:transactions).select("DATE_TRUNC('week', invoices.created_at) AS week").order( Arel.sql("DATE_TRUNC('week', invoices.created_at)")).group("DATE_TRUNC('week', invoices.created_at)").where('transactions.result = ?', 'success').where('invoices.status = ?', 'shipped').sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.unshipped_revenue
    joins(:invoice_items).select('invoices.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS potential_revenue').where('invoices.status = ?', 'packaged').group('invoices.id').sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
