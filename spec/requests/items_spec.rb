require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  # initialize test data
  let!(:merchant) { create(:merchant) }
  let!(:items) { create_list(:item, 10, merchant_id: merchant.id) }
  let(:item_id) { items.first.id }

  describe 'GET /api/v1/items' do
    before { get api_v1_items_path }
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
    it 'returns items' do
      items = JSON.parse(response.body, symbolize_names: true)
      item = items[:data].first
      expect(items).not_to be_empty
      expect(items[:data].count).to eq(10)
      expect(item[:attributes][:name]).to be_a String
      expect(item[:attributes][:unit_price]).to be_a Float
      expect(item[:attributes][:merchant_id]).to be_a Integer
    end
  end
  describe 'GET /api/v1/items/:item_id' do
    before { get api_v1_item_path(item_id) }

    context 'when the record exists' do
      it 'returns the item' do
        item = JSON.parse(response.body, symbolize_names: true)
        expect(item[:data][:type]).to eq('item')
        expect(item[:data][:id]).to eq(item_id.to_s)
        expect(item[:data][:attributes][:name]).to be_a String
        expect(item[:data][:attributes][:description]).to be_a String
        expect(item[:data][:attributes][:unit_price]).to be_a Float
        expect(item[:data][:attributes][:merchant_id]).to be_a Integer
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    context 'when the record doesnt exist' do
      let(:item_id) { 200 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end
end
