FactoryBot.define do
  factory :order do
    user
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
end