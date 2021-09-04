require 'rails_helper'

 RSpec.describe Item do
   describe 'relationships' do
     it { should belong_to(:merchant) }
     it { should have_many(:invoice_items) }
     it { should have_many(:invoices).through(:invoice_items) }
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

       it 'can return one item closest to the search query' do
         merchant = create(:merchant)
         item1 = create(:item, name: 'Samsung', merchant: merchant)
         item2 = create(:item, name: 'Microwave', merchant: merchant)
         item3 = create(:item, merchant: merchant)
         search_query = 'Iphone'

         expect(Item.search_results(search_query)).to eq(nil)
       end
     end
   end
 end
