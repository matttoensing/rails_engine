require 'rails_helper'

 RSpec.describe 'items api' do
   it 'get all items, a maximum of 20 at a time' do
     merchant = create(:merchant)
     create_list(:item, 40, merchant_id: merchant.id)

     get '/api/v1/items?page=1'

     expect(response).to be_successful

     items = JSON.parse(response.body, symbolize_names: true)[:data]

     expect(items.count).to eq(20)

     items.each do |item|
       expect(item).to have_key(:id)
       expect(item[:id]).to be_a(String)

       expect(item[:attributes]).to have_key(:name)
       expect(item[:attributes][:name]).to be_a(String)

       expect(item[:attributes]).to have_key(:description)
       expect(item[:attributes][:description]).to be_a(String)

       expect(item[:attributes]).to have_key(:unit_price)
       expect(item[:attributes][:unit_price]).to be_a(Float)
    end
   end
 end
