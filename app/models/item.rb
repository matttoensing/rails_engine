class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.search_results(query)
    where('LOWER(name) LIKE ?', "%#{query.downcase}%").first
  end
end
