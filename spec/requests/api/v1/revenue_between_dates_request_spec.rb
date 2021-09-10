require 'rails_helper'

 RSpec.describe 'revenue between dates request spec' do
   before(:each) do
     merchant = create(:merchant)
     item1 = create(:item, unit_price: 99.99, merchant: merchant)
     item2 = create(:item, unit_price: 19.99, merchant: merchant)
     item3 = create(:item, unit_price: 49.99, merchant: merchant)
     customer1 = create(:customer)
     customer2 = create(:customer)
     invoice1 = create(:invoice, customer: customer1, merchant: merchant, status: 'shipped',
                                 created_at: DateTime.new(2020, 2, 3))
     invoice2 = create(:invoice, customer: customer1, merchant: merchant, status: 'shipped',
                                 created_at: DateTime.new(2020, 2, 10))
     invoice3 = create(:invoice, customer: customer2, merchant: merchant, status: 'shipped',
                                 created_at: DateTime.new(2020, 3, 3))
     invoice4 = create(:invoice, customer: customer2, merchant: merchant, status: 'shipped',
                                 created_at: DateTime.new(2020, 3, 10))
     transaction1 = create(:transaction, invoice: invoice1, result: 'success')
     transaction2 = create(:transaction, invoice: invoice2, result: 'success')
     transaction3 = create(:transaction, invoice: invoice3, result: 'success')
     transaction4 = create(:transaction, invoice: invoice4, result: 'success')
     invoice_item1 = create(:invoice_item, unit_price: 99.99, quantity: 4, item: item1, invoice: invoice1,
                                           created_at: DateTime.new(2020, 2, 3))
     invoice_item2 = create(:invoice_item, unit_price: 19.99, quantity: 2, item: item2, invoice: invoice2,
                                           created_at: DateTime.new(2020, 2, 10))
     invoice_item3 = create(:invoice_item, unit_price: 49.99, quantity: 2, item: item3, invoice: invoice3,
                                           created_at: DateTime.new(2020, 3, 3))
     invoice_item4 = create(:invoice_item, unit_price: 19.99, quantity: 4, item: item2, invoice: invoice4,
                                           created_at: DateTime.new(2020, 3, 10))

     merchant2 = create(:merchant)
     item4 = create(:item, unit_price: 49.99, merchant: merchant2)
     item5 = create(:item, unit_price: 29.99, merchant: merchant2)
     item6 = create(:item, unit_price: 39.99, merchant: merchant2)
     customer3 = create(:customer)
     customer4 = create(:customer)
     invoice5 = create(:invoice, customer: customer3, merchant: merchant2, status: 'shipped',
                                 created_at: DateTime.new(2020, 2, 3))
     invoice6 = create(:invoice, customer: customer3, merchant: merchant2, status: 'shipped',
                                 created_at: DateTime.new(2020, 2, 10))
     invoice7 = create(:invoice, customer: customer4, merchant: merchant2, status: 'shipped',
                                 created_at: DateTime.new(2020, 3, 3))
     invoice8 = create(:invoice, customer: customer4, merchant: merchant2, status: 'shipped',
                                 created_at: DateTime.new(2020, 3, 10))
     transaction5 = create(:transaction, invoice: invoice5, result: 'success')
     transaction6 = create(:transaction, invoice: invoice6, result: 'success')
     transaction7 = create(:transaction, invoice: invoice7, result: 'success')
     transaction8 = create(:transaction, invoice: invoice8, result: 'success')
     invoice_item5 = create(:invoice_item, unit_price: 49.99, quantity: 4, item: item4, invoice: invoice5,
                                           created_at: DateTime.new(2020, 2, 3))
     invoice_item6 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice6,
                                           created_at: DateTime.new(2020, 2, 10))
     invoice_item7 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice7,
                                           created_at: DateTime.new(2020, 3, 3))
     invoice_item8 = create(:invoice_item, unit_price: 39.99, quantity: 4, item: item6, invoice: invoice8,
                                           created_at: DateTime.new(2020, 3, 10))
   end

   it 'happy path, all revenue if date range is really big' do
     get '/api/v1/revenue', params: {start: "1970-01-01", end: "2100-01-01"}

     expect(response).to be_successful

     revenue = JSON.parse(response.body, symbolize_names: true)

     expect(revenue).to have_key(:data)
     expect(revenue[:data]).to have_key(:attributes)
     expect(revenue[:data][:attributes]).to have_key(:revenue)
     expect(revenue[:data][:attributes][:revenue]).to eq(1099.76)
   end

   it 'happy path, fetch revenue within two dates of a smaller range' do
     get '/api/v1/revenue', params: {start: "2020-02-01", end: "2020-02-14"}

     expect(response).to be_successful

     revenue = JSON.parse(response.body, symbolize_names: true)

     expect(revenue).to have_key(:data)
     expect(revenue[:data]).to have_key(:attributes)
     expect(revenue[:data][:attributes]).to have_key(:revenue)
     expect(revenue[:data][:attributes][:revenue]).to eq(699.88)
   end

   it 'edge case sad path, start date and end date are not provided' do
     get '/api/v1/revenue'

     expect(response).to_not be_successful
     expect(response.status).to eq(400)

     revenue = JSON.parse(response.body, symbolize_names: true)

     expect(revenue).to have_key(:error)
   end

   it 'edge case sad path, start date is provided, but end date is not provided' do
     get '/api/v1/revenue', params: {start: "2020-02-01"}

     expect(response).to_not be_successful
     expect(response.status).to eq(400)

     revenue = JSON.parse(response.body, symbolize_names: true)

     expect(revenue).to have_key(:error)
   end

   it 'edge case sad path, end date is provided, but start date is not provided' do
     get '/api/v1/revenue', params: {end: "2020-02-01"}

     expect(response).to_not be_successful
     expect(response.status).to eq(400)

     revenue = JSON.parse(response.body, symbolize_names: true)

     expect(revenue).to have_key(:error)
   end

   it 'edge case sad path, start date and end date are both blank' do
     get '/api/v1/revenue', params: {start: '', end: ''}

     expect(response).to_not be_successful
     expect(response.status).to eq(400)

     revenue = JSON.parse(response.body, symbolize_names: true)

     expect(revenue).to have_key(:error)
   end

   it 'edge case sad path, start date is set correctly, but end date is blank' do
     get '/api/v1/revenue', params: {start: "2020-02-01", end: ''}

     expect(response).to_not be_successful
     expect(response.status).to eq(400)

     revenue = JSON.parse(response.body, symbolize_names: true)

     expect(revenue).to have_key(:error)
   end

   it 'edge case sad path, end date is set correctly, but start date is blank' do
     get '/api/v1/revenue', params: {start: '', end: '2020-02-01'}

     expect(response).to_not be_successful
     expect(response.status).to eq(400)

     revenue = JSON.parse(response.body, symbolize_names: true)

     expect(revenue).to have_key(:error)
   end
 end
