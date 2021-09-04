require 'rails_helper'

 RSpec.describe 'merchant items api' do
   it 'get all merchant items' do
     merchant = create(:merchant)
     create_list(:item, 10, merchant_id: merchant.id)

     get "/api/v1/merchants/#{merchant.id}/items"

     expect(response).to be_successful

     items = JSON.parse(response.body, symbolize_names: true)[:data]

     expect(items.count).to eq(10)
   end
 end
