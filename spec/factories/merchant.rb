FactoryBot.define do
  factory :merchant do
    name { Faker::Device.manufacturer }
  end
end
