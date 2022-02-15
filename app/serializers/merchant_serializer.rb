class MerchantSerializer
  include JSONAPI::Serializer
  attributes :id, :name
  set_type :merchant

  def self.single_merchant(merchant)
    {
      "data": {
        "id": merchant.id.to_s,
        "type": 'merchant',
        "attributes": {
          "name": merchant.name
        }
      }
    }
  end

  def self.most_items(merchants)
    {
      "data": merchants.map do |merchant|
        {
          "id": merchant.id.to_s,
          "type": 'items_sold',
          'attributes': {
            "name": merchant.name,
            "count": merchant.sold_items
          }
        }
      end
    }
  end
end
