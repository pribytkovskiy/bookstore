FactoryBot.define do
  factory :product do
    title           { FFaker::Book.title }
    price           { FFaker.numerify('##.##') }
    description     { FFaker::DizzleIpsum.paragraphs }
    year            { FFaker::Time.date }
    dimensions      { "#{FFaker.numerify('#.#')}\" #{FFaker.numerify('#.#')}\" #{FFaker.numerify('#.#')}\"" }
    materials       { FFaker::Lorem.words.join ', ' }
    authors { create_list :author, 2 }
    association(:cover)
    association(:category)
  end
end
