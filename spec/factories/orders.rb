FactoryBot.define do
  factory :order do
    user
    state { :canceling }

    trait :with_items do
      order_items { create_list(:order_item, 2) }
    end

    trait :checkout_page do
      order_items { create_list(:order_item, 2) }
      addresses { create :address, kind: 'shipping' }
      addresses { create :address, kind: 'billing' }
      delivery
      card
    end
  end

  factory :order_address, parent: :order do
    state { :address }
  end
end