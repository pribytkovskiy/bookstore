FactoryBot.define do
  factory :card do
   cvv { FFaker.numerify('###') }
   mm_yy { FFaker.numerify('##/##') }
   card_number { FFaker.numerify('#### #### #### ####') }
   name_on_card { FFaker::Name.name }
   association :order
  end
end
