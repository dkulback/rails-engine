require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  # initialize test data
  let!(:merchants) { create_list(:merchant, 10) }
  let(:merchant_id) { merchants.first.id }

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
