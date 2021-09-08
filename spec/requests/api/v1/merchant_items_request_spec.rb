require 'rails_helper'

 RSpec.describe 'merchant items api' do
   it 'get all merchant items(happy path, fetch all items)' do
     merchant = create(:merchant)
     create_list(:item, 10, merchant_id: merchant.id)

     get "/api/v1/merchants/#{merchant.id}/items"

     expect(response).to be_successful

     items = JSON.parse(response.body, symbolize_names: true)[:data]

     expect(items.count).to eq(10)
   end

   it 'sad path, bad integer id returns 404' do
     get '/api/v1/merchants/8923987297/items'

     expect(response).to_not be_successful
     expect(response.status).to eq(404)

     error = JSON.parse(response.body, symbolize_names: true)

     expect(error).to have_key(:message)
   end

   it 'sad path, string id returns 404(extension)' do
     get '/api/v1/merchants/stingy-sting-string/items'

     expect(response).to_not be_successful
     expect(response.status).to eq(404)

     error = JSON.parse(response.body, symbolize_names: true)

     expect(error).to have_key(:error)
   end
 end
