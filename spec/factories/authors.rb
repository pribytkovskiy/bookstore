FactoryBot.define do
  factory :author do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    description { FFaker::DizzleIpsum.paragraphs }

    after(:create) {|author| author.products << FactoryBot.create(:product) }
  end
end
