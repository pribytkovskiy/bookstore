FactoryBot.define do
  factory :card do
   id               { FFaker.numerify('#') }
   cvv              { FFaker.numerify('###') }
   mm_yy            { FFaker.numerify('##/##') }
   card_number      { FFaker.numerify('#### #### #### ####') }
   name_on_card     { FFaker::Name.name }
  end
end