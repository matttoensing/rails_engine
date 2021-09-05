FactoryBot.define do
  factory :item do
    name { Faker::Device.model_name }
    description { Faker::Quote.famous_last_words }
    unit_price { Faker::Number.between(from: 1.00, to: 100.00) }
  end
end
