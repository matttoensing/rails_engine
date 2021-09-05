require 'rails_helper'

 RSpec.describe 'items merchant api' do
   it 'can send an items merchant information' do
     new_merchant = create(:merchant)
     item = create(:item, merchant: new_merchant)

     get "/api/v1/items/#{item.id}/merchant"

     expect(response).to be_successful

     merchant = JSON.parse(response.body, symbolize_names: true)[:data]

     expect(merchant).to have_key(:id)
     expect(merchant[:attributes]).to have_key(:name)
   end
 end
