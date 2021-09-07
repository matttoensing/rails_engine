require 'rails_helper'

 RSpec.describe Item do
   describe 'relationships' do
     it { should belong_to(:merchant) }
     it { should have_many(:invoice_items) }
     it { should have_many(:invoices).through(:invoice_items) }
   end

   describe 'validations' do
     it { should validate_presence_of(:name) }
     it { should validate_presence_of(:description) }
     it { should validate_presence_of(:unit_price) }
   end

   describe 'class methods' do
     describe '#search_results' do
       it 'can return one item closest to the search query' do
         merchant = create(:merchant)
         item1 = create(:item, name: 'Samsung', merchant: merchant)
         item2 = create(:item, name: 'iPhone 4', merchant: merchant)
         item3 = create(:item, merchant: merchant)
         search_query = 'Iphone'

         expect(Item.search_results(search_query)).to eq(item2)
       end
     end

    describe '#find_by_min_price' do
       it 'can return an item closest to a min price range' do
         merchant = create(:merchant)
         item1 = create(:item, unit_price: 99.99, merchant: merchant)
         item2 = create(:item, unit_price: 29.99, merchant: merchant)
         item3 = create(:item, unit_price: 9.99, merchant: merchant)

         min_price = 10.99

         expected = item2

         expect(Item.find_by_min_price(min_price)).to eq(expected)
       end
   end

   describe '#find_by_max_price' do
     it 'can return items above the min price and below the max price' do
       merchant = create(:merchant)
       item1 = create(:item, unit_price: 99.99, merchant: merchant)
       item2 = create(:item, unit_price: 29.99, merchant: merchant)
       item3 = create(:item, unit_price: 9.99, merchant: merchant)

       max_price = 10.99

       expected = item3

       expect(Item.find_by_max_price(max_price)).to eq(expected)
     end
   end

   describe '#find_by_min_max_price' do
     it 'can return items above the min price and below the max price' do
       merchant = create(:merchant)
       item1 = create(:item, unit_price: 99.99, merchant: merchant)
       item2 = create(:item, unit_price: 29.99, merchant: merchant)
       item3 = create(:item, unit_price: 9.99, merchant: merchant)

       min_price = 8.99
       max_price = 30.99

       expected = [item3, item2]

       expect(Item.find_by_min_max_price(min_price, max_price)).to eq(expected)
     end
   end
 end
end
