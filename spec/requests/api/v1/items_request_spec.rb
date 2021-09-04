require 'rails_helper'

 RSpec.describe 'items api' do
   it 'sends a list of all items, a maximum of 20 at a time' do
     merchant = create(:merchant)
     create_list(:item, 40, merchant_id: merchant.id)

     get '/api/v1/items', params: { page: '1'}

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

   it 'can send a request for items for per page parameters' do
     merchant = create(:merchant)
     create_list(:item, 60, merchant_id: merchant.id)

     get '/api/v1/items', params: { per_page: '50'}

     expect(response).to be_successful

     items = JSON.parse(response.body, symbolize_names: true)[:data]

     expect(items.count).to eq(50)
   end

   it 'can get one item by its id' do
     merchant = create(:merchant)
     item = create(:item, merchant: merchant)

     get "/api/v1/items/#{item.id}"

     expect(response).to be_successful

     requested_item = JSON.parse(response.body, symbolize_names: true)[:data]

     expect(requested_item).to have_key(:id)
     expect(requested_item[:attributes]).to have_key(:name)
     expect(requested_item[:attributes]).to have_key(:description)
     expect(requested_item[:attributes]).to have_key(:unit_price)
   end

   it 'can create an item' do
     merchant = create(:merchant)
     item_params = ({
       name: 'Camelot 6',
       description: 'New camming device for wide offwidth climbing',
       unit_price: 120.99,
       merchant_id: merchant.id
       })

     headers = {"CONTENT_TYPE" => 'application/json'}

     post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

     expect(response).to be_successful

     item = Item.last

     expect(item.name).to eq(item_params[:name])
     expect(item.description).to eq(item_params[:description])
     expect(item.unit_price).to eq(item_params[:unit_price])
     expect(item.merchant).to eq(merchant)
   end

   it 'can update an existing item' do
     merchant = create(:merchant)
     item = create(:item, merchant: merchant)
     previous_name = item.name
     item_params = { name: 'Camelot 7' }
     headers = {"CONTENT_TYPE" => 'application/json'}

     patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: item_params)

     expect(response).to be_successful

     found_item = Item.find(item.id)

     expect(found_item.name).to_not eq(previous_name)
     expect(found_item.name).to eq('Camelot 7')
   end

   it 'will return 400 status code if merchant id is bad and not update an existing item' do
     merchant = create(:merchant)
     item = create(:item, merchant: merchant)
     previous_name = item.name
     item_params = { name: 'Camelot 7' }
     headers = {"CONTENT_TYPE" => 'application/json'}

     patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: item_params)

     expect(response).to be_successful
     expect(response.status).to eq(400)
     # { merchant_id: '999999999999' }
     # found_item = Item.find(item.id)

     # expect(found_item.name).to_not eq(previous_name)
     # expect(found_item.name).to eq('Camelot 7')
   end

   it 'can delete an existing item' do
     merchant = create(:merchant)
     item = create(:item, merchant: merchant)

     expect(Item.count).to eq(1)

     delete "/api/v1/items/#{item.id}"

     expect(response).to be_successful
     expect(Item.count).to eq(0)
     expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
   end
 end
