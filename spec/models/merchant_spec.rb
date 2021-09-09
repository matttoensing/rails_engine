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

     describe '#merchants_with_most_revenue' do
       it 'can return merchants with the most revenue based on a given number argument' do
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

         merchant2 = create(:merchant)
         item4 = create(:item, unit_price: 49.99, merchant: merchant2)
         item5 = create(:item, unit_price: 29.99, merchant: merchant2)
         item6 = create(:item, unit_price: 39.99, merchant: merchant2)
         customer3 = create(:customer)
         customer4 = create(:customer)
         invoice5 = create(:invoice, customer: customer3, merchant: merchant2, status: 'shipped')
         invoice6 = create(:invoice, customer: customer3, merchant: merchant2, status: 'shipped')
         invoice7 = create(:invoice, customer: customer4, merchant: merchant2, status: 'shipped')
         invoice8 = create(:invoice, customer: customer4, merchant: merchant2, status: 'shipped')
         transaction5 = create(:transaction, invoice: invoice5, result: 'success')
         transaction6 = create(:transaction, invoice: invoice6, result: 'success')
         transaction7 = create(:transaction, invoice: invoice7, result: 'success')
         transaction8 = create(:transaction, invoice: invoice8, result: 'success')
         invoice_item5 = create(:invoice_item, unit_price: 49.99, quantity: 4, item: item4, invoice: invoice5)
         invoice_item6 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice6)
         invoice_item7 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice7)
         invoice_item8 = create(:invoice_item, unit_price: 39.99, quantity: 4, item: item6, invoice: invoice8)

         expected1 = [merchant]
         expected2 = [merchant, merchant2]

         expect(Merchant.merchants_with_most_revenue(1)).to eq(expected1)
         expect(Merchant.merchants_with_most_revenue(2)).to eq(expected2)
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

         expect(merchant.revenue).to eq(619.88)
       end
     end
   end
 end
