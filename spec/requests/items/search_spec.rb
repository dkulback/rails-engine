require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  describe '/api/v1/items/find_all' do
    context 'when search is valid' do
      it 'returns the items containting that item name' do
        merchant = Merchant.create!(name: 'Merchant Name')
        Item.create!(name: 'Item cool', description: 'Sunt...',
                     unit_price: 42.91, merchant_id: merchant.id)
        Item.create!(name: 'wonderful Item Nemo', description: 'Sunt...',
                     unit_price: 42.91, merchant_id: merchant.id)
        Item.create!(name: 'excellent Item Nemo', description: 'Sunt...',
                     unit_price: 42.91, merchant_id: merchant.id)
        Item.create!(name: 'Nemo', description: 'Sunt...',
                     unit_price: 42.91, merchant_id: merchant.id)

        get api_v1_items_find_all_path, params: { name: 'item' }

        items = JSON.parse(response.body, symbolize_names: true)[:data]
        item = items.first[:attributes]
        expect(items.count).to eq(3)
        expect(item).to have_key(:name)
        expect(item).to have_key(:unit_price)
        expect(item).to have_key(:merchant_id)
        expect(item[:name]).to be_a String
        expect(item[:unit_price]).to be_a Float
        expect(item[:merchant_id]).to be_a Integer
      end
    end
    context 'when it cant find a item' do
      it 'returns an empty array' do
        merchant = Merchant.create!(name: 'Merchant Name')
        Item.create!(name: 'Item cool', description: 'Sunt...',
                     unit_price: 42.91, merchant_id: merchant.id)
        Item.create!(name: 'wonderful Item Nemo', description: 'Sunt...',
                     unit_price: 42.91, merchant_id: merchant.id)
        Item.create!(name: 'excellent Item Nemo', description: 'Sunt...',
                     unit_price: 42.91, merchant_id: merchant.id)
        Item.create!(name: 'Nemo', description: 'Sunt...',
                     unit_price: 42.91, merchant_id: merchant.id)

        get api_v1_items_find_all_path, params: { name: 'inakds' }
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data]).to match([])
      end
      it 'has a status code 200' do
        get api_v1_items_find_all_path, params: { name: '29283' }
        expect(response).to have_http_status(200)
      end
      it 'wont let search field be blank' do
        get api_v1_items_find_all_path, params: { name: '' }
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data][:message]).to eq('NAME CANT BE BLANK')
      end
    end
  end
end
