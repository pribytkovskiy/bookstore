FactoryBot.define do
  factory :order_item do
    id         { FFaker.numerify('#') }
    product_id { FFaker.numerify('#') }
    order_id   { FFaker.numerify('#') }
    quantity   { FFaker.numerify('#') }
  end
end
