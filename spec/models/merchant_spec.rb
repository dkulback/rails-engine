require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe '::search' do
    it 'returns a single merchant based off their name' do
      merchants = create_list(:merchant, 10)
      name = merchants.first.name

      actual = Merchant.search(name)
      expected = merchants.first

      expect(actual).to eq(expected)
    end
  end
end
