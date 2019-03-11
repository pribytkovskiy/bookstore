FactoryBot.define do
  factory :category do
    category { FFaker::Book.genre }
  end
end
