require 'rails_helper'

RSpec.describe 'find item by min price api' do
  it 'happy path, fetch one item by min_price' do
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 99.99, name: 'Offset Alien', merchant: merchant)
    item2 = create(:item, unit_price: 50.03, name: 'Camelot 5', merchant: merchant)

    get '/api/v1/items/find', params: { min_price: 50 }

    expect(response).to be_successful
    expect(response.status).to eq(200)

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes][:name]).to eq(item2.name)
    expect(item[:data][:attributes][:unit_price]).to eq(item2.unit_price)
  end

  it 'happy path, min_price is so big that nothing matches' do
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 99.99, merchant: merchant)
    item2 = create(:item, unit_price: 50.03, merchant: merchant)

    get '/api/v1/items/find', params: { min_price: 100_000_000 }

    expect(response).to be_successful
    expect(response.status).to eq(200)

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item).to have_key(:data)
    expect(item[:data]).to have_key(:error)
    expect(item[:data][:error]).to eq('no items meet this price')
  end

  it 'sad path, cannot send name and min_price' do
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 99.99, merchant: merchant)
    item2 = create(:item, unit_price: 50.03, merchant: merchant)

    get '/api/v1/items/find', params: { name: 'ring', min_price: 100_000_000 }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key(:error)
  end

  it 'sad path, cannot send name and max_price' do
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 99.99, merchant: merchant)
    item2 = create(:item, unit_price: 50.03, merchant: merchant)

    get '/api/v1/items/find', params: { name: 'ring', max_price: 100 }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key(:error)
  end

  it 'happy path, fetch one item by max price' do
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 99.99, merchant: merchant)
    item2 = create(:item, unit_price: 50.03, merchant: merchant)

    get '/api/v1/items/find', params: { max_price: 150 }

    expect(response).to be_successful
    expect(response.status).to eq(200)

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes][:name]).to eq(item1.name)
    expect(item[:data][:attributes][:unit_price]).to eq(item1.unit_price)
  end

  it 'happy path, max_price is so small that nothing matches' do
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 99.99, merchant: merchant)
    item2 = create(:item, unit_price: 50.03, merchant: merchant)

    get '/api/v1/items/find', params: { max_price: 150 }

    expect(response).to be_successful
    expect(response.status).to eq(200)

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes][:name]).to eq(item1.name)
    expect(item[:data][:attributes][:unit_price]).to eq(item1.unit_price)
  end

  it 'sad path, min_price less than 0 ' do
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 99.99, merchant: merchant)
    item2 = create(:item, unit_price: 50.03, merchant: merchant)

    get '/api/v1/items/find', params: { min_price: -5 }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end

  it 'happy path, can send both min and max params at the same time' do
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 99.99, merchant: merchant)
    item2 = create(:item, unit_price: 50.03, merchant: merchant)

    get '/api/v1/items/find', params: { min_price: 5, max_price: 100 }

    expect(response).to be_successful
    expect(response.status).to eq(200)

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items).to have_key(:data)
  end

  describe 'extensions' do
    it 'edge case, no name given' do
      merchant = create(:merchant)
      item1 = create(:item, unit_price: 99.99, merchant: merchant)
      item2 = create(:item, unit_price: 50.03, merchant: merchant)

      get '/api/v1/items/find', params: { name: ''}

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
      expect(error).to have_key(:error)
    end

    it 'no param given' do
      merchant = create(:merchant)
      item1 = create(:item, unit_price: 99.99, merchant: merchant)
      item2 = create(:item, unit_price: 50.03, merchant: merchant)

      get '/api/v1/items/find'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
      expect(error).to have_key(:error)
    end

    it 'edge case, min_price cannot be more than max_price' do
      merchant = create(:merchant)
      item1 = create(:item, unit_price: 99.99, merchant: merchant)
      item2 = create(:item, unit_price: 50.03, merchant: merchant)

      get '/api/v1/items/find', params: {min_price: 100, max_price: 50}

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
      expect(error).to have_key(:error)
    end
  end
end
