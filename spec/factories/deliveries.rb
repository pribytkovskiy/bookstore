FactoryBot.define do
  factory :delivery do
    price  { FFaker.numerify('##.##') }
    days   { FFaker.numerify('#') }
  end
end
