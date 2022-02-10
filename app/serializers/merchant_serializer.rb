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
end
