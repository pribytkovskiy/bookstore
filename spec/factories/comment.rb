FactoryBot.define do
  factory :comment do
    comments   { FFaker::DizzleIpsum.paragraphs }
    rate       { FFaker::Random.rand(1..5) }
    user_id    { create(:user).id }
    product_id { create(:book).id }
  end
end
