FactoryBot.define do
  factory :order_item do
    association :product
    association :order
    quantity   { FFaker.numerify('#') }
  end
end
