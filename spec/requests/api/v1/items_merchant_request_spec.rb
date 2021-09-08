require 'rails_helper'

 RSpec.describe 'items merchant api' do
   it 'can send an items merchant information(happy path, fetch one merchant by id)' do
     item_merchant = create(:merchant)
     item = create(:item, merchant: item_merchant)

     get "/api/v1/items/#{item.id}/merchant"

     expect(response).to be_successful

     merchant = JSON.parse(response.body, symbolize_names: true)[:data]

     expect(merchant).to have_key(:id)
     expect(merchant[:attributes]).to have_key(:name)
   end

   it 'sad path, bad integer id returns 404' do
     merchant = create(:merchant)
     item = create(:item, merchant: merchant)

     get "/api/v1/items/929827372891/merchant"

     expect(response).to_not be_successful
     expect(response.status).to eq(404)
   end

   it 'edge case, string id returns 404' do
     merchant = create(:merchant)
     item = create(:item, merchant: merchant)

     get "/api/v1/items/stringy-string-string/merchant"

     expect(response).to_not be_successful
     expect(response.status).to eq(404)
   end
 end
