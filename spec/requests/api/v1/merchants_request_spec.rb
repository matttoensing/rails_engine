require 'rails_helper'

RSpec.describe 'merchants api' do
  it 'sends a list of merchants(happy path, fetching page 1 is the same list of first 20 in db)' do
    create_list(:merchant, 40)

    get '/api/v1/merchants', params: {page: 1}

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(20)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'sends a list of merchants from the first page if params page is less than or equal to zero(sad path, fetching page 1 if page is 0 or lower)' do
    create_list(:merchant, 40)

    get '/api/v1/merchants', params: {page: 0}

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(20)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'happy path, fetch second page of 20 merchants' do
    create_list(:merchant, 40)

    get '/api/v1/merchants', params: {page: 2}

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(20)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end

    expect(merchants[-1][:attributes][:name]).to eq(Merchant.last.name)
  end

  it 'sends a list of merchants from per page params(happy path, fetch first page of 50 merchants)' do
    create_list(:merchant, 100)

    get '/api/v1/merchants', params: {per_page: 50}

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(50)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'happy path, fetch a page of merchants which would contain no data' do
    create_list(:merchant, 100)

    get '/api/v1/merchants', params: {page: 200}

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to have_key(:data)
    expect(merchants[:data].count).to eq(0)
  end

  it 'happy path, fetch all merchants if per page is really big' do
    create_list(:merchant, 100)

    get '/api/v1/merchants', params: {per_page: 20000}

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(100)
  end

  it 'can get one merchant by its id(happy path, fetch one merchant by id)' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(merchant).to have_key(:id)
    expect(merchant[:id].to_i).to eq(id)
    expect(merchant[:attributes]).to have_key(:name)
  end

  it 'sends an error response for a bad merchant id(sad path, bad integer id returns 404)' do

    get "/api/v1/merchants/282828282828282"

    expect(response).not_to be_successful
    expect(response.status).to eq(404)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error).to have_key(:message)
  end
end
