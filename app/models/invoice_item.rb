class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  # has_many :transactions, through: :invoices
end
