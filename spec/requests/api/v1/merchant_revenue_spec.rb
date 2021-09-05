require 'rails_helper'

RSpec.describe 'total merchant revenue api' do
  it 'can send merchant total revenue' do
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 99.99, merchant: merchant)
    item2 = create(:item, unit_price: 19.99, merchant: merchant)
    item3 = create(:item, unit_price: 49.99, merchant: merchant)
    customer1 = create(:customer)
    customer2 = create(:customer)
    invoice1 = create(:invoice, customer: customer1, merchant: merchant, status: 'shipped')
    invoice2 = create(:invoice, customer: customer1, merchant: merchant, status: 'shipped')
    invoice3 = create(:invoice, customer: customer2, merchant: merchant, status: 'shipped')
    invoice4 = create(:invoice, customer: customer2, merchant: merchant, status: 'shipped')
    transaction1 = create(:transaction, invoice: invoice1, result: 'success')
    transaction2 = create(:transaction, invoice: invoice2, result: 'success')
    transaction3 = create(:transaction, invoice: invoice3, result: 'success')
    transaction4 = create(:transaction, invoice: invoice4, result: 'success')
    invoice_item1 = create(:invoice_item, unit_price: 99.99, quantity: 4, item: item1, invoice: invoice1)
    invoice_item2 = create(:invoice_item, unit_price: 19.99, quantity: 2, item: item2, invoice: invoice2)
    invoice_item3 = create(:invoice_item, unit_price: 49.99, quantity: 2, item: item3, invoice: invoice3)
    invoice_item4 = create(:invoice_item, unit_price: 19.99, quantity: 4, item: item2, invoice: invoice4)

    get "/api/v1/revenue/merchants/#{merchant.id}"

    expect(response).to be_successful

    merchant_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_response).to have_key(:data)
    expect(merchant_response[:data]).to have_key(:id)
    expect(merchant_response[:data]).to have_key(:type)
    expect(merchant_response[:data][:type]).to eq("merchant_revenue")
    expect(merchant_response[:data]).to have_key(:attributes)
    expect(merchant_response[:data][:attributes][:revenue]).to eq(619.88)
  end
end
