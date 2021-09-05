class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  # scope :total_revenue, -> {sum(unit_price * quantity)}
end
