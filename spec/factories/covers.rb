FactoryBot.define do
  factory :cover do
    image_url { FFaker::Lorem.words.join }
  end
end
