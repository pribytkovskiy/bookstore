class Order < ApplicationRecord
  belongs_to :user
  belongs_to :delivery
  belongs_to :coupon
  has_many :line_items, dependent: :destroy

  validates :card_number, :name_on_card, :mm_yy, :cvv, presence: true
  validates :card_number, length: { minimum: 10 },
            format: { with: /\A[0-9]+\z/, message: 'please enter a valid credit card number' }
  validates :name_on_card, length: { maximum: 50 }, format: { with: /\A[a-zA-Z]+\z/, message: 'only allows letters' }
  validates :mm_yy, format: { with: /\A(0{1}([0-9]){1}|1{1}([0-2]){1})\/\d{2}\z/,
            message: 'the expiration date must be MM/YY' }
  validates :cvv, length: { maximum: 4 }
end
