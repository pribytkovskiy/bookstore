FactoryBot.define do
  factory :address do
    first_name          { FFaker::Name.first_name }
    last_name           { FFaker::Name.last_name }
    address             { FFaker::Address.street_name }
    city                { FFaker::Address.city }
    zip                 { 11_111 }
    country             { 'Ukraine' }
    phone               { '+380661026745' }
  end

  factory :users_address, parent: :address do
    addressable { create :user }

    trait :shipping do
      kind :shipping
    end

    trait :billing do
      kind :billing
    end
  end

  factory :orders_address, parent: :users_address do
    addressable { create :order }
  end
end