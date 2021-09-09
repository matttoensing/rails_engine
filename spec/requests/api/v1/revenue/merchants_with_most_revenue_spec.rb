require 'rails_helper'

 RSpec.describe 'merchants with most revenue api' do
   before(:each) do
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
     invoice8 = create(:invoice, customer: customer4, merchant: merchant2, status: 'pending')
     transaction5 = create(:transaction, invoice: invoice5, result: 'success')
     transaction6 = create(:transaction, invoice: invoice6, result: 'success')
     transaction7 = create(:transaction, invoice: invoice7, result: 'success')
     transaction8 = create(:transaction, invoice: invoice8, result: 'success')
     invoice_item5 = create(:invoice_item, unit_price: 49.99, quantity: 4, item: item4, invoice: invoice5)
     invoice_item6 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice6)
     invoice_item7 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice7)
     invoice_item8 = create(:invoice_item, unit_price: 39.99, quantity: 4, item: item6, invoice: invoice8)
   end

   it 'happy path, top one merchant by revenue' do
     get '/api/v1/revenue/merchants', params: { quantity: 1 }

     expect(response).to be_successful

     requested_merchants = JSON.parse(response.body, symbolize_names: true)

     expect(requested_merchants[:data].length).to eq(1)

     merchants = requested_merchants[:data]

     merchants.each do |merchant|
       expect(merchant).to have_key(:attributes)
       expect(merchant).to have_key(:type)
       expect(merchant[:type]).to eq('merchant_name_revenue')
     end
   end

   it 'happy path, all 100 merchants if quantity is too big' do
     get '/api/v1/revenue/merchants', params: { quantity: 100000 }

     expect(response).to be_successful

     requested_merchants = JSON.parse(response.body, symbolize_names: true)

     expect(requested_merchants[:data].count).to eq(2)

     merchants = requested_merchants[:data]

     merchants.each do |merchant|
       expect(merchant).to have_key(:attributes)
       expect(merchant).to have_key(:type)
       expect(merchant[:type]).to eq('merchant_name_revenue')
     end
   end

   it 'sad path, returns an error of some sort if quantity is a string' do
     get '/api/v1/revenue/merchants', params: { quantity: 'asdasd' }

     expect(response).to_not be_successful
     expect(response.status).to eq(400)
   end

   it 'edge case sad path, quantity param is missing' do
     get '/api/v1/revenue/merchants'

     expect(response).to_not be_successful
     expect(response.status).to eq(400)
   end
 end
