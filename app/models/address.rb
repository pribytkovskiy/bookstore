class Address < ApplicationRecord
  belongs_to :order # dependent: :nulify
  belongs_to :user # dependent: :nulify
  enum address_type: [ :billing, :shipping ]

  scope :search_billing, -> { where(address_type: :billing) }
  scope :search_shipping, -> { where(address_type: :shipping) }
end