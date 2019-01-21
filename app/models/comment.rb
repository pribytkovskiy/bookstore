class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  
  validates :rate, :body, presence: true
  validates :rate, length: { maximum: 1 }, format: { with: /\A[1-5]+\z/, message: 'please enter a valid rating: 1-5' }
end
 