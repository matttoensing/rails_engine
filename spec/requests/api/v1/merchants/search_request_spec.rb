require 'rails_helper'

RSpec.describe 'merchants search api' do
  it 'can send a list of merchants based off of search criteria(happy path, fetch all merchants matching a pattern)' do
    merchant1 = create(:merchant, name: 'Ace Hardware')
    merchant2 = create(:merchant, name: 'Boulder Hardware Store')
    merchant3 = create(:merchant, name: 'Generic Pet Supply')
    search_query = 'Hardware'

    get '/api/v1/merchants/find_all', params: { name: search_query }

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to have_key(:data)
    expect(merchants[:data]).to be_an(Array)
  end

  it 'sad path, no fragment matched' do
    merchant1 = create(:merchant, name: 'Ace Hardware')
    merchant2 = create(:merchant, name: 'Boulder Hardware Store')
    merchant3 = create(:merchant, name: 'Generic Pet Supply')
    search_query = 'Restaurant'

    get '/api/v1/merchants/find_all', params: { name: search_query }

    expect(response.status).to eq(400)

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to have_key(:data)
  end

  describe 'extensions' do
    it 'edge case, no name given' do
      merchant = create(:merchant, name: 'Ace Hardware')

      get '/api/v1/merchants/find_all', params: { name: '' }

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:error)
    end
  end
end
