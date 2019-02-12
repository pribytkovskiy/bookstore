FactoryBot.define do
  factory :coupon do
    id     { FFaker.numerify('#') }
    number { FFaker.numerify('#') }
    price  { FFaker.numerify('##.##') }
  end
end