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

  # Test suite for GET /merchants/:merchant_id/items/:id
  describe 'GET /merchants/:merchant_id/items/:id' do
    before { get "/merchants/#{merchant_id}/items/#{id}" }

    context 'when todo item exists' do
      xit 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      xit 'returns the item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when todo item does not exist' do
      let(:id) { 0 }

      xit 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      xit 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for PUT /merchants/:merchant_id/items
  describe 'POST /merchants/:merchant_id/items' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false } }

    context 'when request attributes are valid' do
      before { post "/merchants/#{merchant_id}/items", params: valid_attributes }

      xit 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/merchants/#{merchant_id}/items", params: {} }

      xit 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      xit 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /merchants/:merchant_id/items/:id
  describe 'PUT /merchants/:merchant_id/items/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }

    before { put "/merchants/#{merchant_id}/items/#{id}", params: valid_attributes }

    context 'when item exists' do
      xit 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      xit 'updates the item' do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/Mozart/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      xit 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      xit 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for DELETE /merchants/:id
  describe 'DELETE /merchants/:id' do
    before { delete "/merchants/#{merchant_id}/items/#{id}" }

    xit 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
