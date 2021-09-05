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

   describe 'class methods' do
     describe '::weekly_revenue' do
       it 'can calculate weekly revenue' do
         merchant = create(:merchant)
         item1 = create(:item, unit_price: 99.99, merchant: merchant)
         item2 = create(:item, unit_price: 19.99, merchant: merchant)
         item3 = create(:item, unit_price: 49.99, merchant: merchant)
         customer1 = create(:customer)
         customer2 = create(:customer)
         invoice1 = create(:invoice, customer: customer1, merchant: merchant, status: 'shipped', created_at: DateTime.new(2020, 2, 3))
         invoice2 = create(:invoice, customer: customer1, merchant: merchant, status: 'shipped', created_at: DateTime.new(2020, 2, 10))
         invoice3 = create(:invoice, customer: customer2, merchant: merchant, status: 'shipped', created_at: DateTime.new(2020, 3, 3))
         invoice4 = create(:invoice, customer: customer2, merchant: merchant, status: 'shipped', created_at: DateTime.new(2020, 3, 10))
         transaction1 = create(:transaction, invoice: invoice1, result: 'success')
         transaction2 = create(:transaction, invoice: invoice2, result: 'success')
         transaction3 = create(:transaction, invoice: invoice3, result: 'success')
         transaction4 = create(:transaction, invoice: invoice4, result: 'success')
         invoice_item1 = create(:invoice_item, unit_price: 99.99, quantity: 4, item: item1, invoice: invoice1, created_at: DateTime.new(2020, 2, 3))
         invoice_item2 = create(:invoice_item, unit_price: 19.99, quantity: 2, item: item2, invoice: invoice2, created_at: DateTime.new(2020, 2, 10))
         invoice_item3 = create(:invoice_item, unit_price: 49.99, quantity: 2, item: item3, invoice: invoice3, created_at: DateTime.new(2020, 3, 3))
         invoice_item4 = create(:invoice_item, unit_price: 19.99, quantity: 4, item: item2, invoice: invoice4, created_at: DateTime.new(2020, 3, 10))

         merchant2 = create(:merchant)
         item4 = create(:item, unit_price: 49.99, merchant: merchant2)
         item5 = create(:item, unit_price: 29.99, merchant: merchant2)
         item6 = create(:item, unit_price: 39.99, merchant: merchant2)
         customer3 = create(:customer)
         customer4 = create(:customer)
         invoice5 = create(:invoice, customer: customer3, merchant: merchant2, status: 'shipped', created_at: DateTime.new(2020, 2, 3))
         invoice6 = create(:invoice, customer: customer3, merchant: merchant2, status: 'shipped', created_at: DateTime.new(2020, 2, 10))
         invoice7 = create(:invoice, customer: customer4, merchant: merchant2, status: 'shipped', created_at: DateTime.new(2020, 3, 3))
         invoice8 = create(:invoice, customer: customer4, merchant: merchant2, status: 'shipped', created_at: DateTime.new(2020, 3, 10))
         transaction5 = create(:transaction, invoice: invoice5, result: 'success')
         transaction6 = create(:transaction, invoice: invoice6, result: 'success')
         transaction7 = create(:transaction, invoice: invoice7, result: 'success')
         transaction8 = create(:transaction, invoice: invoice8, result: 'success')
         invoice_item5 = create(:invoice_item, unit_price: 49.99, quantity: 4, item: item4, invoice: invoice5, created_at: DateTime.new(2020, 2, 3))
         invoice_item6 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice6, created_at: DateTime.new(2020, 2, 10))
         invoice_item7 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice7, created_at: DateTime.new(2020, 3, 3))
         invoice_item8 = create(:invoice_item, unit_price: 39.99, quantity: 4, item: item6, invoice: invoice8, created_at: DateTime.new(2020, 3, 10))

         expected = {DateTime.new(2020, 2, 3).to_time => 599.92, DateTime.new(2020, 2, 10).to_time => 99.96, DateTime.new(2020, 3, 2).to_time => 159.96, DateTime.new(2020, 3, 9).to_time => 239.92000000000002}

         expect(InvoiceItem.weekly_revenue).to eq(expected)
       end
     end
   end
 end
