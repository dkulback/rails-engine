FactoryBot.define do
  factory :item do
    merchant_id { nil }
    name { Faker::Name.name }
    description { Faker::Quote.famous_last_words }
    unit_price { Faker::Number.between(from: 100.15, to: 576.99) }
  end
end
