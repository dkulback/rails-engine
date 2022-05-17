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
  describe 'POST api/v1/items' do
    let(:valid_attributes) do
      { name: 'Item Nemo Facere', description: 'Sunt eum id eius magni consequuntur delectus verit...',
        unit_price: 42.91, merchant_id: merchant.id }
    end
    context 'when request attributes are valid' do
      before { post api_v1_items_path, params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post api_v1_items_path, params: { merchant_id: merchant.id } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:message]).to match(/your query could not be completed/)
        expect(json[:errors].count).to eq(3)
        expect(json[:errors][0]).to eq("Name can't be blank")
        expect(json[:errors][1]).to eq("Unit price can't be blank")
        expect(json[:errors][2]).to eq("Description can't be blank")
      end
    end
  end
  describe 'DELETE api/vi/items/item_id' do
    before { delete api_v1_item_path(item_id) }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
  describe 'PUT api/vi/items/item_id' do
    context 'when attributes are valid' do
      let(:valid_attributes) { { name: 'new item name', unit_cost: 1028.39 } }
      before { put api_v1_item_path(item_id), params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    context 'when attributes are invalid' do
      let(:invalid_attributes) { { merchant_id: 9_999_999_999_999 } }
      before { put api_v1_item_path(item_id), params: invalid_attributes }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
