require 'rails_helper'
RSpec.describe 'Merchant items API' do
  # Initialize the test data
  let!(:merchant) { create(:merchant) }
  let!(:items) { create_list(:item, 10, merchant_id: merchant.id) }
  let(:merchant_id) { merchant.id }
  let(:id) { items.first.id }

  # Test suite for GET /merchants/:merchant_id/items
  describe 'GET /merchants/:merchant_id/items' do
    before { get api_v1_merchant_items_path(merchant_id) }
    let(:merch_items) { JSON.parse(response.body, symbolize_names: true) }
    context 'when mechant exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all the merchant items' do
        item = merch_items[:data].first
        expect(merch_items[:data].size).to eq(10)
        expect(item[:attributes][:description]).to be_a String
        expect(item[:attributes][:name]).to be_a String
        expect(item[:attributes][:merchant_id]).to be_a Integer
        expect(item[:attributes][:unit_price]).to be_a Float
      end
    end

    context 'when todo does not exist' do
      let(:merchant_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Merchant/)
      end
    end
  end
end
