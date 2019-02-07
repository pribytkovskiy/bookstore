class Address < ApplicationRecord
  belongs_to :order
  belongs_to :user
  enum type: [ :billing, :shipping ]

  scope :billing, -> { where(type: :billing) }
  scope :shipping, -> { where(type: :shipping) }

  ONLY_LETTERS = /\A[а-яА-ЯёЁa-zA-Z]+\z/
  ONLY_NUMBERS = /\A[0-9]+\z/
  STARTS_WITH_PLUS = /\A^\+[0-9]+\z/

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
  validates :first_name, :last_name, :address, :city, :country, :phone, length: { maximum: 50 }
  validates :first_name, :last_name, :city, :country,
            format: { with: ONLY_LETTERS, message: I18n.t('only_letters') }
  validates :zip, length: { maximum: 10 }, format: { with: ONLY_NUMBERS, message: I18n.t('only_numbers') }
  validates :phone, length: { maximum: 15 },
            format: { with: STARTS_WITH_PLUS, message: I18n.t('starts_with_plus') }
end