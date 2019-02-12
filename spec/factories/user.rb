FactoryBot.define do
  factory :user do
    email               { FFaker::Internet.email }
    role                { 'admin' }
    pictures            { 'test' }
  end
end