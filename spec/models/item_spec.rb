require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end
  describe '::search' do
    it 'searches and returns all items matching name field' do
      merchant = Merchant.create!(name: 'Merchant')
      item_1 = Item.create!(name: 'Item cool', description: 'Sunt...',
                            unit_price: 42.91, merchant_id: merchant.id)
      item_2 = Item.create!(name: 'wonderful Item Nemo', description: 'Sunt...',
                            unit_price: 42.91, merchant_id: merchant.id)
      item_3 = Item.create!(name: 'excellent Item Nemo', description: 'Sunt...',
                            unit_price: 42.91, merchant_id: merchant.id)
      Item.create!(name: 'Nemo', description: 'Sunt...',
                   unit_price: 42.91, merchant_id: merchant.id)
      actual = Item.search('item')
      expected = [item_1, item_3, item_2]
      expect(actual).to eq(expected)
    end
  end
end
