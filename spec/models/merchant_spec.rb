require 'rails_helper'

 RSpec.describe Merchant do
   describe 'relationships' do
     it { should have_many(:invoices) }
     it { should have_many(:items) }
     it { should have_many(:customers).through(:invoices) }
   end

   describe 'class methods' do
     describe '#search_results' do
       it 'can return a list of merchants based on a given search query' do
        merchant1 = create(:merchant, name: 'Apple')
        merchant2 = create(:merchant, name: 'Apple Pies')
        merchant3 = create(:merchant, name: 'Ford')

        expected = [merchant1, merchant2]

        expect(Merchant.search_results('apple')).to eq(expected)
       end

       it 'will return no merchants if search query does not meet any merchant names' do
         merchant1 = create(:merchant, name: 'Apple')
         merchant2 = create(:merchant, name: 'Apple Pies')
         merchant3 = create(:merchant, name: 'Ford')

         expect(Merchant.search_results('chevy')).to eq(nil)
       end
     end
   end

   describe 'instance methods' do
     describe '::total_revenue' do
       it 'can return total revenue for a single merchant' do
         merchant = create(:merchant)
         item1 = create(:item, unit_price: 99.99, merchant: merchant)
         item2 = create(:item, unit_price: 19.99, merchant: merchant)
         item3 = create(:item, unit_price: 49.99, merchant: merchant)
         customer1 = create(:customer)
         customer2 = create(:customer)
         invoice1 = create(:invoice, customer: customer1, merchant: merchant, status: 'shipped')
         invoice2 = create(:invoice, customer: customer1, merchant: merchant, status: 'shipped')
         invoice3 = create(:invoice, customer: customer2, merchant: merchant, status: 'shipped')
         invoice4 = create(:invoice, customer: customer2, merchant: merchant, status: 'shipped')
         transaction1 = create(:transaction, invoice: invoice1, result: 'success')
         transaction2 = create(:transaction, invoice: invoice2, result: 'success')
         transaction3 = create(:transaction, invoice: invoice3, result: 'success')
         transaction4 = create(:transaction, invoice: invoice4, result: 'success')
         invoice_item1 = create(:invoice_item, unit_price: 99.99, quantity: 4, item: item1, invoice: invoice1)
         invoice_item2 = create(:invoice_item, unit_price: 19.99, quantity: 2, item: item2, invoice: invoice2)
         invoice_item3 = create(:invoice_item, unit_price: 49.99, quantity: 2, item: item3, invoice: invoice3)
         invoice_item4 = create(:invoice_item, unit_price: 19.99, quantity: 4, item: item2, invoice: invoice4)

         expect(merchant.total_revenue).to eq(619.88)
       end
     end
   end
 end
