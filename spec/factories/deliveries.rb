FactoryBot.define do
  factory :delivery do
    method { FFaker::Lorem.words.join }
    price  { FFaker.numerify('##.##') }
    days   { FFaker.numerify('#') }
  end
end
