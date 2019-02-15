FactoryBot.define do
  factory :user do
    email               { FFaker::Internet.email }
    role                { 'admin' }
    pictures            { FFaker::Lorem.words.join }
    password            { FFaker::Internet.password }
  end
end