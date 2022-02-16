class InvoiceSerializer
  def self.total_rev(rev)
    {
      "data": {
        "id": nil,
        "type": 'revenue',
        "attributes": {
          "revenue": rev
        }
      }
    }
  end
end
