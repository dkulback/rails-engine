class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  validates_presence_of :name, :unit_price, :description

  def self.search(name)
    where('name ILIKE ?', "%#{name.downcase}%").order(:name)
  end

end
