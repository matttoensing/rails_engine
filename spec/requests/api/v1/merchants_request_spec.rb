require 'rails_helper'

RSpec.describe 'merchants api' do
  it 'sends a list of merchants' do
    create_list(:merchant, 40)

    get '/api/v1/merchants?page=1'

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
end
