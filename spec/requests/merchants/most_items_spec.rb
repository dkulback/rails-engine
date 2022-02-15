require 'rails_helper'

RSpec.describe 'most items API', type: :request do
  describe 'GET /api/v1/merchants/most_items' do
    context 'when query is valid' do
      it 'returns the number of merchants with most items sold' do
        merchant_1 = Merchant.create!(name: 'DILLON')
        merchant_2 = Merchant.create!(name: 'ILLO')
        merchant_3 = Merchant.create!(name: 'LON')
        item_1 = Item.create!(name: 'Nem cere', description: 'verit', unit_price: 42.91, merchant_id: merchant_1.id)
        item_2 = Item.create!(name: 'Nem cere', description: 'verit', unit_price: 42.91, merchant_id: merchant_2.id)
        item_3 = Item.create!(name: 'Nem cere', description: 'verit', unit_price: 42.91, merchant_id: merchant_3.id)
        customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
        invoice_1 = Invoice.create!(merchant_id: merchant_1.id, customer_id: customer_1.id, status:
                                   'shipped')
        invoice_2 = Invoice.create!(merchant_id: merchant_2.id, customer_id: customer_1.id, status:
                                   'shipped')
        invoice_3 = Invoice.create!(merchant_id: merchant_3.id, customer_id: customer_1.id, status: 'shipped')
        invoice_4 = Invoice.create!(merchant_id: merchant_3.id, customer_id: customer_1.id, status:
                                   'packaged')
        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5,
                                             unit_price: 1.35)
        invoice_item_2 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5,
                                             unit_price: 1.35)
        invoice_item_3 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 3,
                                             unit_price: 1.35)
        invoice_item_4 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_2.id, quantity: 5,
                                             unit_price: 1.35)

        invoice_item_5 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_3.id, quantity: 5,
                                             unit_price: 1.35)
        Transaction.create!(invoice_id: invoice_1.id, result: 'success')
        Transaction.create!(invoice_id: invoice_2.id, result: 'success')
        Transaction.create!(invoice_id: invoice_2.id, result: 'refunded')
        Transaction.create!(invoice_id: invoice_3.id, result: 'success')
        Transaction.create!(invoice_id: invoice_4.id, result: 'success')

        get api_v1_merchants_most_items_path, params: { quantity: 2 }

        merchants = JSON.parse(response.body, symbolize_names: true)
        expect(merchants[:data].count).to eq(2)
        expect(merchants[:data][0][:type]).to eq('items_sold')
        expect(merchants[:data][0][:attributes][:name]).to eq('DILLON')
        expect(merchants[:data][1][:attributes][:name]).to eq('ILLO')
      end
    end
  end
end
