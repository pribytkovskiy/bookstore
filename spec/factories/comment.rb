FactoryBot.define do
  factory :comment do
    title      { FFaker::Book.title }
    body       { FFaker::DizzleIpsum.paragraphs }
    rate       { FFaker::Random.rand(1..5) }
    approved   { :approved }
    user_id    { create(:user).id }
    product_id { create(:product).id }
  end
end
