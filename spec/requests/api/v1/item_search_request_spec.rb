require 'rails_helper'

 RSpec.describe 'items search api' do
   it 'can return one item based off a search' do
     merchant = create(:merchant)
     item1 = create(:item, name: 'Samsung', merchant: merchant)
     item2 = create(:item, name: 'iPhone 4', merchant: merchant)
     search_query = 'Iphone'

     get '/api/v1/items/search', params: { query: search_query}

     item = JSON.parse(response.body, symbolize_names: true)

     expect(item.count).to eq(1)

     data = item[:data]

     expect(data).to have_key(:id)
     expect(data[:attributes]).to have_key(:name)
     expect(data[:attributes]).to have_key(:description)
     expect(data[:attributes]).to have_key(:unit_price)
     expect(data[:attributes][:name]).to eq('iPhone 4')
   end
 end
