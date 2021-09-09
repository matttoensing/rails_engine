class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices

  def self.search_results(query)
    merchants = where('LOWER(name) LIKE ?', "%#{query.downcase}%")
    merchants.empty? ? nil : merchants
  end

  def revenue
    invoices.joins(:invoice_items)
            .joins(:transactions)
            .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
            .where('invoices.status = ?', 'shipped')
            .where('transactions.result = ?', 'success')
            .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.merchants_with_most_revenue(quantity)
    find_by_sql("SELECT SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue, merchants.id, merchants.name FROM merchants INNER JOIN invoices ON invoices.merchant_id = merchants.id INNER JOIN invoice_items ON invoice_items.invoice_id = invoices.id INNER JOIN transactions ON transactions.invoice_id = invoices.id WHERE (status = 'shipped') AND (result = 'success') GROUP BY merchants.id ORDER BY revenue DESC LIMIT #{quantity}")
  end
end
