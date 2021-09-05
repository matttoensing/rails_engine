require 'rails_helper'

 RSpec.describe 'revenue report api' do
   before(:each) do
     @merchant = create(:merchant)
     @item1 = create(:item, unit_price: 99.99, merchant: @merchant)
     @item2 = create(:item, unit_price: 19.99, merchant: @merchant)
     @item3 = create(:item, unit_price: 49.99, merchant: @merchant)
     @customer1 = create(:customer)
     @customer2 = create(:customer)
     @invoice1 = create(:invoice, customer: @customer1, merchant: @merchant, status: 'shipped', created_at: DateTime.new(2020, 2, 3, 5, 5, 5))
     @invoice2 = create(:invoice, customer: @customer1, merchant: @merchant, status: 'shipped', created_at: DateTime.new(2020, 2, 10, 5, 5, 5))
     @invoice3 = create(:invoice, customer: @customer2, merchant: @merchant, status: 'shipped', created_at: DateTime.new(2020, 3, 3, 5, 5, 5))
     @invoice4 = create(:invoice, customer: @customer2, merchant: @merchant, status: 'shipped', created_at: DateTime.new(2020, 3, 10, 5, 5, 5))
     @transaction1 = create(:transaction, invoice: @invoice1, result: 'success')
     @transaction2 = create(:transaction, invoice: @invoice2, result: 'success')
     @transaction3 = create(:transaction, invoice: @invoice3, result: 'success')
     @transaction4 = create(:transaction, invoice: @invoice4, result: 'success')
     @invoice_item1 = create(:invoice_item, unit_price: 99.99, quantity: 4, item: @item1, invoice: @invoice1)
     @invoice_item2 = create(:invoice_item, unit_price: 19.99, quantity: 2, item: @item2, invoice: @invoice2)
     @invoice_item3 = create(:invoice_item, unit_price: 49.99, quantity: 2, item: @item3, invoice: @invoice3)
     @invoice_item4 = create(:invoice_item, unit_price: 19.99, quantity: 4, item: @item2, invoice: @invoice4)

     @merchant2 = create(:merchant)
     @item4 = create(:item, unit_price: 49.99, merchant: @merchant2)
     @item5 = create(:item, unit_price: 29.99, merchant: @merchant2)
     @item6 = create(:item, unit_price: 39.99, merchant: @merchant2)
     @customer3 = create(:customer)
     @customer4 = create(:customer)
     @invoice5 = create(:invoice, customer: @customer3, merchant: @merchant2, status: 'shipped', created_at: DateTime.new(2020, 2, 3, 5, 5, 5))
     @invoice6 = create(:invoice, customer: @customer3, merchant: @merchant2, status: 'shipped', created_at: DateTime.new(2020, 2, 10, 5, 5, 5))
     @invoice7 = create(:invoice, customer: @customer4, merchant: @merchant2, status: 'shipped', created_at: DateTime.new(2020, 3, 3, 5, 5, 5))
     @invoice8 = create(:invoice, customer: @customer4, merchant: @merchant2, status: 'shipped', created_at: DateTime.new(2020, 3, 10, 5, 5, 5))
     @transaction5 = create(:transaction, invoice: @invoice5, result: 'success')
     @transaction6 = create(:transaction, invoice: @invoice6, result: 'success')
     @transaction7 = create(:transaction, invoice: @invoice7, result: 'success')
     @transaction8 = create(:transaction, invoice: @invoice8, result: 'success')
     @invoice_item5 = create(:invoice_item, unit_price: 99.99, quantity: 4, item: @item4, invoice: @invoice5)
     @invoice_item6 = create(:invoice_item, unit_price: 19.99, quantity: 2, item: @item4, invoice: @invoice6)
     @invoice_item7 = create(:invoice_item, unit_price: 49.99, quantity: 2, item: @item5, invoice: @invoice7)
     @invoice_item8 = create(:invoice_item, unit_price: 19.99, quantity: 4, item: @item6, invoice: @invoice8)
   end

   it 'can send a revenue report, broken down by month in ascending date order' do
     # revenue report, broken down by month in ascending date order
     get '/api/v1/revenue/weekly'

     expect(response).to be_successful

     data = JSON.parse(response.body, symbolize_names: true)

     expect(data[:data][0]).to have_key(:id)
     expect(data[:data][0][:id]).to eq(nil)
     expect(data[:data][0]).to have_key(:type)
     expect(data[:data][0][:type]).to eq("weekly_revenue")
     expect(data[:data][0]).to have_key(:attributes)
     expect(data[:data][0][:attributes]).to have_key(:week)
     expect(data[:data][0][:attributes]).to have_key(:revenue)
   end
 end
