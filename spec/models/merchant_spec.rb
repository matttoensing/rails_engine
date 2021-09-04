require 'rails_helper'

 RSpec.describe Merchant do
   describe 'relationships' do
     it { should have_many(:invoices) }
     it { should have_many(:items) }
     it { should have_many(:customers).through(:invoices) }
   end

   describe 'class methods' do
     describe '#search_results' do
       it 'can return a list of merchants based on a given search query' do
        merchant1 = create(:merchant, name: 'Apple')
        merchant2 = create(:merchant, name: 'Apple Pies')
        merchant3 = create(:merchant, name: 'Ford')

        expected = [merchant1, merchant2]

        expect(Merchant.search_results('apple')).to eq(expected)
       end

       it 'will return no merchants if search query does not meet any merchant names' do
         merchant1 = create(:merchant, name: 'Apple')
         merchant2 = create(:merchant, name: 'Apple Pies')
         merchant3 = create(:merchant, name: 'Ford')

         expect(Merchant.search_results('chevy')).to eq(nil)
       end
     end
   end
 end
