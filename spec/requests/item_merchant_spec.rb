require 'rails_helper'

RSpec.describe 'Items Merchant API', type: :request do
  # initialize test data
  let!(:merchant) { create(:merchant) }
  let!(:items) { create_list(:item, 1, merchant_id: merchant.id) }
  let(:item_id) { items.first.id }

  describe 'GET /api/v1/items/:id/merchant' do
    context 'when item id is valid' do
      before { get api_v1_item_merchant_index_path(item_id) }
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns the merchant' do
        merchant = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(merchant[:type]).to eq('merchant')
        expect(merchant[:attributes][:name]).to be_a String
      end
    end
  end
  context 'when item id is invalid' do
    let(:item_id) { 10_000_000 }
    before { get api_v1_item_merchant_index_path(item_id) }
    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end
    it 'returns a validation error' do
      expect(response.body).to match(/Couldn't find Item/)
    end
  end
end
