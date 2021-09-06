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

  def self.merchants_with_most_revenue(quantity)
      x = find_by_sql("SELECT SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue, merchants.id, merchants.name FROM merchants INNER JOIN invoices ON invoices.merchant_id = merchants.id INNER JOIN invoice_items ON invoice_items.invoice_id = invoices.id INNER JOIN transactions ON transactions.invoice_id = invoices.id WHERE (status = 'shipped') WHERE (result = 'success') GROUP BY merchants.id ORDER BY revenue DESC LIMIT #{quantity}")
      # require "pry"; binding.pry
  end

  # def self.most_revenue
  #   x = find_by_sql('SELECT SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue, merchants.id AS merchants_id FROM "merchants" INNER JOIN "invoices" ON "invoices"."merchant_id" = "merchants"."id" INNER JOIN "invoice_items" ON "invoice_items"."invoice_id" = "invoices"."id" INNER JOIN "transactions" ON "transactions"."invoice_id" = "invoices"."id" WHERE (invoices.status = 'shipped') GROUP BY merchants.id')
  # end
end


  # joins(invoices: [:invoice_items, :transactions]).group('merchants.id').select('merchants.id, merchants.name, invoice_items.quantity, invoice_items.unit_price').where('invoices.status = ?', 'shipped').sum('invoice_items.quantity * invoice_items.unit_price')
