class Transaction < ApplicationRecord
  belongs_to :invoice

  scope :successful_transactions, -> { where('result  = ?', 'success') }
end
