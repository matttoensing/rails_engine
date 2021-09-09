require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  # describe 'instance methods' do
  #   describe '::total_revenue' do
  #     it 'can return total revenue for a single merchant' do
  #       merchant = create(:merchant)
  #       item = create(:item, unit_price: 99.99, merchant: merchant)
  #       customer = create(:customer)
  #       invoice = create(:invoice, customer: customer, merchant: merchant, status: 'shipped')
  #       transaction = create(:transaction, invoice: invoice, result: 'success')
  #       invoice_item = create(:invoice_item, unit_price: 99.99, quantity: 4, item: item, invoice: invoice)
  #
  #
  #       expect(InvoiceItem.total_revenue).to eq(399.96)
  #     end
  #   end
  # end
end
