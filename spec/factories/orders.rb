FactoryBot.define do
  factory :order do
    user
    state { :canceling }

    trait :with_items do
      order_items { create_list(:order_item, 2) }
    end
  end

  factory :order_address, parent: :order do
    state { :address }
  end

  factory :order_checkout_page, parent: :order do
    delivery { create :delivery }
    card { create :card }
    state { :confirmation }

    after(:create) do |order|
      order.addresses << FactoryBot.create(:users_address, :shipping)
      order.addresses << FactoryBot.create(:users_address, :billing)
    end
  end
end
