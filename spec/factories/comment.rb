FactoryBot.define do
  factory :comment do
    comments   { FFaker::DizzleIpsum.paragraphs }
    rate       { FFaker::Random.rand(1..5) }
    user_id    { create(:user).id }
    product_id { create(:book).id }
  end
end

commenter: nil, body: nil, comments: nil, rate: 0, user_id: nil, product_id: nil