class Card < ApplicationRecord
    has_many :orders

    ONLY_LETTERS = /\A[а-яА-ЯёЁa-zA-Z]+\z/

    validates :card_number, :name_on_card, :mm_yy, :cvv, presence: true
    validates :card_number, length: { is: 16 }, numericality: { only_integer: true }
    validates :name_on_card, length: { maximum: 50 }, format: { with: ONLY_LETTERS, message: I18n.t('only_letters') }
    #validates :mm_yy, format: { with: /\A(0{1}([0-9]){1}|1{1}([0-2]){1})\/\d{2}\z/, message: 'the expiration date must be MM/YY' }
    validates :cvv, length: { in: 3..4 }
  end
  