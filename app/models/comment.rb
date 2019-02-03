class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rate, :body, presence: true
  validates_inclusion_of :rate, in: 1..5
end
