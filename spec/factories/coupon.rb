FactoryBot.define do
  factory :coupon do
    number { FFaker.numerify('#') }
    price  { FFaker.numerify('##.##') }
  end
end
