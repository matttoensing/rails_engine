require 'rails_helper'

 RSpec.describe 'potential revenue of unshipped orders' do
   before(:each) do
     merchant = create(:merchant)
     item1 = create(:item, unit_price: 99.99, merchant: merchant)
     item2 = create(:item, unit_price: 19.99, merchant: merchant)
     item3 = create(:item, unit_price: 49.99, merchant: merchant)
     customer1 = create(:customer)
     customer2 = create(:customer)
     invoice1 = create(:invoice, customer: customer1, merchant: merchant, status: 'packaged')
     invoice2 = create(:invoice, customer: customer1, merchant: merchant, status: 'shipped')
     invoice3 = create(:invoice, customer: customer2, merchant: merchant, status: 'shipped')
     invoice4 = create(:invoice, customer: customer2, merchant: merchant, status: 'packaged')
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
     invoice5 = create(:invoice, customer: customer3, merchant: merchant2, status: 'packaged')
     invoice6 = create(:invoice, customer: customer3, merchant: merchant2, status: 'shipped')
     invoice7 = create(:invoice, customer: customer4, merchant: merchant2, status: 'shipped')
     invoice8 = create(:invoice, customer: customer4, merchant: merchant2, status: 'packaged')
     transaction5 = create(:transaction, invoice: invoice5, result: 'success')
     transaction6 = create(:transaction, invoice: invoice6, result: 'success')
     transaction7 = create(:transaction, invoice: invoice7, result: 'success')
     transaction8 = create(:transaction, invoice: invoice8, result: 'success')
     invoice_item5 = create(:invoice_item, unit_price: 49.99, quantity: 4, item: item4, invoice: invoice5)
     invoice_item6 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice6)
     invoice_item7 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice7)
     invoice_item8 = create(:invoice_item, unit_price: 39.99, quantity: 4, item: item6, invoice: invoice8)
   end

   it 'can send a list of invoices with unshipped status and include revenue' do
     get '/api/v1/revenue/unshipped'

     expect(response).to be_successful

     invoices = JSON.parse(response.body, symbolize_names: true)

     expect(invoices[:data].count).to eq(4)
   end

   it 'can request a list of invoices with unshipped status and include revenue with a specified quantity' do
     get '/api/v1/revenue/unshipped', params: {quantity: 2}

     expect(response).to be_successful

     invoices = JSON.parse(response.body, symbolize_names: true)

     expect(invoices[:data].count).to eq(2)
   end

   it 'returns an error of some sort if quantity value is blank' do
     get '/api/v1/revenue/unshipped', params: {quantity: ''}

     expect(response).not_to be_successful
     expect(response.status).to eq(400)
   end

   it 'returns an error of some sort if quantity is a string' do
     get '/api/v1/revenue/unshipped', params: {quantity: 'asdasd'}

     expect(response).to_not be_successful
     expect(response.status).to eq(400)
   end
 end
