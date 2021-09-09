require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) }
  end

  describe 'class methods' do
    describe '::weekly_revenue' do
      it 'can calculate weekly revenue' do
        merchant = create(:merchant)
        item1 = create(:item, unit_price: 99.99, merchant: merchant)
        item2 = create(:item, unit_price: 19.99, merchant: merchant)
        item3 = create(:item, unit_price: 49.99, merchant: merchant)
        customer1 = create(:customer)
        customer2 = create(:customer)
        invoice1 = create(:invoice, customer: customer1, merchant: merchant, status: 'shipped',
                                    created_at: DateTime.new(2020, 2, 3))
        invoice2 = create(:invoice, customer: customer1, merchant: merchant, status: 'shipped',
                                    created_at: DateTime.new(2020, 2, 10))
        invoice3 = create(:invoice, customer: customer2, merchant: merchant, status: 'shipped',
                                    created_at: DateTime.new(2020, 3, 3))
        invoice4 = create(:invoice, customer: customer2, merchant: merchant, status: 'shipped',
                                    created_at: DateTime.new(2020, 3, 10))
        transaction1 = create(:transaction, invoice: invoice1, result: 'success')
        transaction2 = create(:transaction, invoice: invoice2, result: 'success')
        transaction3 = create(:transaction, invoice: invoice3, result: 'success')
        transaction4 = create(:transaction, invoice: invoice4, result: 'success')
        invoice_item1 = create(:invoice_item, unit_price: 99.99, quantity: 4, item: item1, invoice: invoice1,
                                              created_at: DateTime.new(2020, 2, 3))
        invoice_item2 = create(:invoice_item, unit_price: 19.99, quantity: 2, item: item2, invoice: invoice2,
                                              created_at: DateTime.new(2020, 2, 10))
        invoice_item3 = create(:invoice_item, unit_price: 49.99, quantity: 2, item: item3, invoice: invoice3,
                                              created_at: DateTime.new(2020, 3, 3))
        invoice_item4 = create(:invoice_item, unit_price: 19.99, quantity: 4, item: item2, invoice: invoice4,
                                              created_at: DateTime.new(2020, 3, 10))

        merchant2 = create(:merchant)
        item4 = create(:item, unit_price: 49.99, merchant: merchant2)
        item5 = create(:item, unit_price: 29.99, merchant: merchant2)
        item6 = create(:item, unit_price: 39.99, merchant: merchant2)
        customer3 = create(:customer)
        customer4 = create(:customer)
        invoice5 = create(:invoice, customer: customer3, merchant: merchant2, status: 'shipped',
                                    created_at: DateTime.new(2020, 2, 3))
        invoice6 = create(:invoice, customer: customer3, merchant: merchant2, status: 'shipped',
                                    created_at: DateTime.new(2020, 2, 10))
        invoice7 = create(:invoice, customer: customer4, merchant: merchant2, status: 'shipped',
                                    created_at: DateTime.new(2020, 3, 3))
        invoice8 = create(:invoice, customer: customer4, merchant: merchant2, status: 'shipped',
                                    created_at: DateTime.new(2020, 3, 10))
        transaction5 = create(:transaction, invoice: invoice5, result: 'success')
        transaction6 = create(:transaction, invoice: invoice6, result: 'success')
        transaction7 = create(:transaction, invoice: invoice7, result: 'success')
        transaction8 = create(:transaction, invoice: invoice8, result: 'success')
        invoice_item5 = create(:invoice_item, unit_price: 49.99, quantity: 4, item: item4, invoice: invoice5,
                                              created_at: DateTime.new(2020, 2, 3))
        invoice_item6 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice6,
                                              created_at: DateTime.new(2020, 2, 10))
        invoice_item7 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice7,
                                              created_at: DateTime.new(2020, 3, 3))
        invoice_item8 = create(:invoice_item, unit_price: 39.99, quantity: 4, item: item6, invoice: invoice8,
                                              created_at: DateTime.new(2020, 3, 10))

        expected = { DateTime.new(2020, 2, 3).to_time => 599.92, DateTime.new(2020, 2, 10).to_time => 99.96,
                     DateTime.new(2020, 3, 2).to_time => 159.96, DateTime.new(2020, 3, 9).to_time => 239.92000000000002 }

        expect(Invoice.weekly_revenue).to eq(expected)
      end
    end

    describe '::unshipped_revenue' do
      it 'can calculate revenue for each invoice with status of packaged' do
        merchant = create(:merchant)
        item1 = create(:item, unit_price: 99.99, merchant: merchant)
        item2 = create(:item, unit_price: 19.99, merchant: merchant)
        item3 = create(:item, unit_price: 49.99, merchant: merchant)
        customer1 = create(:customer)
        customer2 = create(:customer)
        invoice1 = create(:invoice, customer: customer1, merchant: merchant, status: 'packaged')
        invoice2 = create(:invoice, customer: customer1, merchant: merchant, status: 'shipped')
        invoice3 = create(:invoice, customer: customer2, merchant: merchant, status: 'shipped')
        invoice4 = create(:invoice, customer: customer2, merchant: merchant, status: 'packaged')
        transaction1 = create(:transaction, invoice: invoice1, result: 'success')
        transaction2 = create(:transaction, invoice: invoice2, result: 'success')
        transaction3 = create(:transaction, invoice: invoice3, result: 'success')
        transaction4 = create(:transaction, invoice: invoice4, result: 'success')
        invoice_item1 = create(:invoice_item, unit_price: 99.99, quantity: 4, item: item1, invoice: invoice1)
        invoice_item2 = create(:invoice_item, unit_price: 19.99, quantity: 2, item: item2, invoice: invoice2)
        invoice_item3 = create(:invoice_item, unit_price: 49.99, quantity: 2, item: item3, invoice: invoice3)
        invoice_item4 = create(:invoice_item, unit_price: 19.99, quantity: 4, item: item2, invoice: invoice4)

        merchant2 = create(:merchant)
        item4 = create(:item, unit_price: 49.99, merchant: merchant2)
        item5 = create(:item, unit_price: 29.99, merchant: merchant2)
        item6 = create(:item, unit_price: 39.99, merchant: merchant2)
        customer3 = create(:customer)
        customer4 = create(:customer)
        invoice5 = create(:invoice, customer: customer3, merchant: merchant2, status: 'packaged')
        invoice6 = create(:invoice, customer: customer3, merchant: merchant2, status: 'shipped')
        invoice7 = create(:invoice, customer: customer4, merchant: merchant2, status: 'shipped')
        invoice8 = create(:invoice, customer: customer4, merchant: merchant2, status: 'packaged')
        transaction5 = create(:transaction, invoice: invoice5, result: 'success')
        transaction6 = create(:transaction, invoice: invoice6, result: 'success')
        transaction7 = create(:transaction, invoice: invoice7, result: 'success')
        transaction8 = create(:transaction, invoice: invoice8, result: 'success')
        invoice_item5 = create(:invoice_item, unit_price: 49.99, quantity: 4, item: item4, invoice: invoice5)
        invoice_item6 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice6)
        invoice_item7 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice7)
        invoice_item8 = create(:invoice_item, unit_price: 39.99, quantity: 4, item: item6, invoice: invoice8)

        expected = [invoice1, invoice4, invoice5, invoice8]

        expect(Invoice.unshipped_revenue).to eq(expected)

        expected2 = Invoice.unshipped_revenue

        expect(expected2[0].revenue).to eq(399.96)
        expect(expected2[1].revenue).to eq(79.96)
        expect(expected2[2].revenue).to eq(199.96)
        expect(expected2[3].revenue).to eq(159.96)
      end
    end

    describe '::revenue_between_dates' do
      it 'can determine total revenue between dates' do
        merchant = create(:merchant)
        item1 = create(:item, unit_price: 99.99, merchant: merchant)
        item2 = create(:item, unit_price: 19.99, merchant: merchant)
        item3 = create(:item, unit_price: 49.99, merchant: merchant)
        customer1 = create(:customer)
        customer2 = create(:customer)
        invoice1 = create(:invoice, customer: customer1, merchant: merchant, status: 'shipped',
                                    created_at: DateTime.new(2020, 2, 3))
        invoice2 = create(:invoice, customer: customer1, merchant: merchant, status: 'shipped',
                                    created_at: DateTime.new(2020, 2, 10))
        invoice3 = create(:invoice, customer: customer2, merchant: merchant, status: 'shipped',
                                    created_at: DateTime.new(2020, 3, 3))
        invoice4 = create(:invoice, customer: customer2, merchant: merchant, status: 'shipped',
                                    created_at: DateTime.new(2020, 3, 10))
        transaction1 = create(:transaction, invoice: invoice1, result: 'success')
        transaction2 = create(:transaction, invoice: invoice2, result: 'success')
        transaction3 = create(:transaction, invoice: invoice3, result: 'success')
        transaction4 = create(:transaction, invoice: invoice4, result: 'success')
        invoice_item1 = create(:invoice_item, unit_price: 99.99, quantity: 4, item: item1, invoice: invoice1,
                                              created_at: DateTime.new(2020, 2, 3))
        invoice_item2 = create(:invoice_item, unit_price: 19.99, quantity: 2, item: item2, invoice: invoice2,
                                              created_at: DateTime.new(2020, 2, 10))
        invoice_item3 = create(:invoice_item, unit_price: 49.99, quantity: 2, item: item3, invoice: invoice3,
                                              created_at: DateTime.new(2020, 3, 3))
        invoice_item4 = create(:invoice_item, unit_price: 19.99, quantity: 4, item: item2, invoice: invoice4,
                                              created_at: DateTime.new(2020, 3, 10))

        merchant2 = create(:merchant)
        item4 = create(:item, unit_price: 49.99, merchant: merchant2)
        item5 = create(:item, unit_price: 29.99, merchant: merchant2)
        item6 = create(:item, unit_price: 39.99, merchant: merchant2)
        customer3 = create(:customer)
        customer4 = create(:customer)
        invoice5 = create(:invoice, customer: customer3, merchant: merchant2, status: 'shipped',
                                    created_at: DateTime.new(2020, 2, 3))
        invoice6 = create(:invoice, customer: customer3, merchant: merchant2, status: 'shipped',
                                    created_at: DateTime.new(2020, 2, 10))
        invoice7 = create(:invoice, customer: customer4, merchant: merchant2, status: 'shipped',
                                    created_at: DateTime.new(2020, 3, 3))
        invoice8 = create(:invoice, customer: customer4, merchant: merchant2, status: 'shipped',
                                    created_at: DateTime.new(2020, 3, 10))
        transaction5 = create(:transaction, invoice: invoice5, result: 'success')
        transaction6 = create(:transaction, invoice: invoice6, result: 'success')
        transaction7 = create(:transaction, invoice: invoice7, result: 'success')
        transaction8 = create(:transaction, invoice: invoice8, result: 'success')
        invoice_item5 = create(:invoice_item, unit_price: 49.99, quantity: 4, item: item4, invoice: invoice5,
                                              created_at: DateTime.new(2020, 2, 3))
        invoice_item6 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice6,
                                              created_at: DateTime.new(2020, 2, 10))
        invoice_item7 = create(:invoice_item, unit_price: 29.99, quantity: 2, item: item5, invoice: invoice7,
                                              created_at: DateTime.new(2020, 3, 3))
        invoice_item8 = create(:invoice_item, unit_price: 39.99, quantity: 4, item: item6, invoice: invoice8,
                                              created_at: DateTime.new(2020, 3, 10))

        start_date1 = "1970-02-01"
        end_date1 = "2100-01-01"
        start_date2 = "2020-02-01"
        end_date2 = "2020-02-14"

        expect(Invoice.revenue_between_dates(start_date1, end_date1)).to eq(1099.76)
        expect(Invoice.revenue_between_dates(start_date2, end_date2)).to eq(699.88)
      end
    end
  end
end
