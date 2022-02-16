require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to :merchant }
  it { should belong_to :customer }
  it { should have_many :invoice_items }
  it { should have_many :transactions }

  describe '::sales_over/2' do
    it 'returns total rev over a period of start and end dates' do
      merchant_1 = Merchant.create!(name: 'merchant_name')
      customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
      item_1 = Item.create!(name: 'Itee', description: 'verit.',
                            unit_price: 42.91, merchant_id: merchant_1.id)
      invoice_1 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant_1.id,
                                  status: 'shipped', created_at: '2012-03-09 05:54:09')
      invoice_2 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant_1.id,
                                  status: 'shipped', created_at: '2012-03-11 00:00:00')
      invoice_3 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant_1.id,
                                  status: 'shipped', created_at: '2012-03-18 20:00:00')
      invoice_4 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant_1.id,
                                  status: 'shipped', created_at: '2012-03-20 05:54:09')
      InvoiceItem.create!(item_id: item_1.id,
                          invoice_id: invoice_1.id,
                          quantity: 1235, unit_price: 100.00)
      InvoiceItem.create!(item_id: item_1.id,
                          invoice_id: invoice_2.id,
                          quantity: 10, unit_price: 100.00)
      InvoiceItem.create!(item_id: item_1.id,
                          invoice_id: invoice_3.id,
                          quantity: 15, unit_price: 100.00)
      InvoiceItem.create!(item_id: item_1.id,
                          invoice_id: invoice_4.id,
                          quantity: 1235, unit_price: 100.00)
      Transaction.create!(invoice_id: invoice_1.id, result: 'success')
      Transaction.create!(invoice_id: invoice_2.id, result: 'success')
      Transaction.create!(invoice_id: invoice_3.id, result: 'success')
      Transaction.create!(invoice_id: invoice_2.id, result: 'refunded')
      Transaction.create!(invoice_id: invoice_1.id, result: 'success')

      actual = Invoice.sales_over('2012-03-10', '2012-03-19')
      expected = 2500
      expect(actual).to eq(expected)
    end
  end
end
