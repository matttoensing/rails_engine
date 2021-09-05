require 'rails_helper'

 RSpec.describe 'items search api' do
   it 'can send one item based off a search' do
     merchant = create(:merchant)
     item1 = create(:item, name: 'Samsung', merchant: merchant)
     item2 = create(:item, name: 'iPhone 4', merchant: merchant)
     search_query = 'Iphone'

     get '/api/v1/items/find', params: { name: search_query}

     expect(response).to be_successful

     item = JSON.parse(response.body, symbolize_names: true)

     expect(item.count).to eq(1)

     data = item[:data]

     expect(data).to have_key(:id)
     expect(data[:attributes]).to have_key(:name)
     expect(data[:attributes]).to have_key(:description)
     expect(data[:attributes]).to have_key(:unit_price)
     expect(data[:attributes][:name]).to eq('iPhone 4')
   end

   it 'will not send an item if no items match search query' do
     merchant = create(:merchant)
     item1 = create(:item, name: 'Samsung', merchant: merchant)
     item2 = create(:item, name: 'Microwave', merchant: merchant)
     search_query = 'Iphone'

     get '/api/v1/items/find', params: { name: search_query}

      expect(response.status).to eq(400)

     error_message = JSON.parse(response.body, symbolize_names: true)

     expect(error_message).to have_key(:data)
     expect(error_message[:data]).to have_key(:message)
     expect(error_message[:data]).to have_key(:errors)
   end
 end
