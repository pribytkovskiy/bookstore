FactoryBot.define do
  factory :author_products do
    association :author
    association :product
  end
end
