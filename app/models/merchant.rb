class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices

  def self.search_results(query)
    merchants = where('LOWER(name) LIKE ?', "%#{query.downcase}%")
    merchants.empty? ? nil : merchants
  end

  def total_revenue
    invoices.joins(:invoice_items).joins(:transactions).select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue').where('invoices.status = ?', 'shipped').where('transactions.result = ?', 'success').sum('invoice_items.quantity * invoice_items.unit_price')
  end
end



# invoices.joins(:invoice_items).joins(:transactions).select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue').where('invoices.status = ?', 'shipped').where('transactions.result = ?', 'success')

# find_by_sql("SELECT  SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue FROM invoices INNER JOIN invoice_items ON invoice_items.invoice_id = invoices.id INNER JOIN transactions ON transactions.invoice_id = invoices.id WHERE invoices.merchant_id = #{self.id} AND (invoices.status = 'shipped') AND (transactions.result = 'success')")
