class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  def self.search(name)
    where('name ILIKE ?', "%#{name.downcase}%").order(:name)
  end

  def self.most_items(qty = 5)
    # select('merchants.*, sum(invoice_items.quantity) as sold_items').joins(:invoice_items, :transactions).where(
    #   transactions: { result: 'success' }, invoices: { status: 'shipped' }
    # ).group(:id).order(sold_items: :desc).limit(qty)
    joins(invoice_items: { invoice: :transactions })
      .select('merchants.*, SUM(invoice_items.quantity) AS sold_items')
      .where('transactions.result = ?', 'success')
      .where('invoices.status = ?', 'shipped')
      .group(:id)
      .order(sold_items: :desc)
      .limit(qty)
  end

  def item(id)
    items.find(id)
  end
end
