require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  # initialize test data
  let!(:merchants) { create_list(:merchant, 10) }
  let(:merchant_id) { merchants.first.id }

  describe 'GET /api/v1/merchants' do
    before { get api_v1_merchants_path }
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
    it 'returns merchants' do
      merchants = JSON.parse(response.body, symbolize_names: true)
      merchant = merchants[:data].first
      expect(merchants).not_to be_empty
      expect(merchants[:data].count).to eq(10)

      expect(merchant[:attributes][:name]).to be_a String
      expect(merchant[:attributes][:id]).to be_a Integer
    end
  end
  describe 'GET /api/v1/merchants/:merchant_id' do
    before { get api_v1_merchant_path(merchant_id) }

    context 'when the record exists' do
      it 'returns the merchant' do
        merchant = JSON.parse(response.body, symbolize_names: true)
        expect(merchant[:data][:type]).to eq('merchant')
        expect(merchant[:data][:id]).to eq(merchant_id.to_s)
        expect(merchant[:data][:attributes][:name]).to be_a String
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    context 'when the record doesnt exist' do
      let(:merchant_id) { 200 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
        expect(response.body).to match(/Couldn't find Merchant/)
      end
    end
  end
  describe 'GET api/v1/merchants/find' do
    before { get api_v1_merchants_find_path, params: { name: merchants.first.name } }
    it 'returns the merchant(s) with that name' do
      merchant = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(merchant[:type]).to eq('merchant')
      expect(merchant[:id]).to be_a String
      expect(merchant[:attributes][:name]).to be_a String
    end
    context 'when it cant find a merchant' do
      before { get api_v1_merchants_find_path, params: { name: 'NOTAMERCHANT' } }
      it 'returns unable to find merchant' do
        expect(response.body).to match(/Unable to find Merchant/)
      end
      it 'has a status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
