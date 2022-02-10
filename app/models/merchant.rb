class Merchant < ApplicationRecord
  has_many :items

  def self.search(name)
    where('name ILIKE ?', "%#{name.downcase}%").order(:name).first
  end
end
