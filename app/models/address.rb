class Address < ApplicationRecord
  belongs_to :order
  belongs_to :user
  enum type: [ :billing, :shipping ]
end