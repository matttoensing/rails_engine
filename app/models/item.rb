class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def self.search_results(query)
    where('LOWER(name) LIKE ?', "%#{query.downcase}%").first
  end

  def self.find_by_min_price(min_price)
    where('unit_price >= ?', min_price).order(:unit_price).first
  end

  def self.find_by_max_price(max_price)
    where('unit_price <= ?', max_price).order(unit_price: :desc).first
  end

  def self.find_by_min_max_price(min_price, max_price)
    where("unit_price <= #{max_price} AND unit_price >= #{min_price}").order(:unit_price)
  end
end
