class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items

  def self.sales_over(start_date, end_date)
    where('invoices.created_at > ?', "#{start_date} 00:00:00")
      .where('invoices.created_at < ?', "#{end_date} 24:00:00")
      .where(invoices: { status: 'shipped' }).joins(:invoice_items, :transactions)
      .where(transactions: { result: 'success' })
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
