class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices

  def self.search_results(query)
    merchants = where('LOWER(name) LIKE ?', "%#{query.downcase}%")
    merchants.empty? ? nil : merchants
  end
end
