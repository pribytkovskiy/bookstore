FactoryBot.define do
  factory :user do
    email               { FFaker::Internet.email }
    role                { 'admin' }
    pictures            { FFaker::Lorem.words.join }
    password            { FFaker::Internet.password }

    trait :with_orders do
      orders { create_list(:order, 3) }
    end

    trait :with_orders_address do
      orders { create_list(:order_address, 1) }
    end
  end
end