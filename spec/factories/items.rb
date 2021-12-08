FactoryBot.define do
  factory :item do
    name { Faker::Books::Dune.character }
    description { Faker::Books::Dune.saying}
    unit_price { Faker::Number.decimal(l_digits: 2) }
    merchant
  end
end