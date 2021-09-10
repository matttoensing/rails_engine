class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  scope :shipped_invoices, -> { where('status = ?', 'shipped') }

  def self.weekly_revenue
    joins(:invoice_items)
      .joins(:transactions)
      .select("DATE_TRUNC('week', invoices.created_at) AS week")
      .order(Arel.sql("DATE_TRUNC('week', invoices.created_at)"))
      .group("DATE_TRUNC('week', invoices.created_at)")
      .merge(Transaction.successful_transactions)
      .merge(Invoice.shipped_invoices)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.unshipped_revenue
    find_by_sql("SELECT SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue, invoices.id FROM invoices INNER JOIN invoice_items ON invoice_items.invoice_id = invoices.id WHERE (invoices.status = 'packaged') GROUP BY invoices.id")
  end

  def self.revenue_between_dates(start_date, end_date)
    joins(:transactions)
      .joins(:invoice_items)
      .select('SUM(invoice_items.quantity * invoice_items.unit_price)')
      .where("invoices.created_at BETWEEN '#{start_date}' AND '#{end_date.to_date + 1.day}'")
      .merge(Transaction.successful_transactions)
      .merge(Invoice.shipped_invoices)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
