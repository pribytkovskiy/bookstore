FactoryBot.define do
  factory :user do
    email               { FFaker::Internet.email }
    role                { 'admin' }
    pictures            { FFaker::Lorem.words.join }
    password            { FFaker::Internet.password }

    trait :with_orders do
      orders { create_list(:order, 3) }
    end
  end
end