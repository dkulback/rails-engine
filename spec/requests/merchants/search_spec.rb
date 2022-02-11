require 'rails_helper'

RSpec.describe 'Merchant Search API', type: :request do
  # initialize test data

  describe 'GET api/v1/merchants/find' do
    it 'returns the best first merchant matching the search' do
      merchant_1 = Merchant.create!(name: 'Turing')
      merchant_1 = Merchant.create!(name: 'A Merchant')
      merchant_1 = Merchant.create!(name: 'Ring World')
      merchant_1 = Merchant.create!(name: 'New Merchant')
      get api_v1_merchants_find_path, params: { name: 'ring' }
      merchant = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(merchant[:type]).to eq('merchant')
      expect(merchant[:id]).to be_a String
      expect(merchant[:attributes][:name]).to eq('Ring World')
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
    context 'when the search field is blank' do
      before { get api_v1_merchants_find_path, params: { name: '' } }
      it 'returns an error message search cant be blank' do
        expect(response.body).to match(/Search field can't be blank/)
      end
      it 'resturns :bad_request status code 400' do
        expect(response.status).to eq(400)
      end
    end
  end
end
