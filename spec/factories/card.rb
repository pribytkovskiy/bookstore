FactoryBot.define do
  factory :card do
   cvv { FFaker.numerify('###') }
   mm_yy { '12/21' }
   card_number { FFaker.numerify('################') }
   name_on_card { FFaker::Name.first_name }
   association :order
  end
end
