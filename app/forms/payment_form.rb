class PaymentForm
  include ActiveModel::Model
  include Virtus.model

  ONLY_LETTERS = /\A[а-яА-ЯёЁa-zA-Z]+\z/

  attribute :card_number, String
  attribute :name_on_card, String
  attribute :cvv, Integer
  attribute :mm_yy, String
  attribute :order_id, Integer

  validates :card_number, :name_on_card, :mm_yy, :cvv, presence: true
  validates :card_number, length: { is: 16 }, numericality: { only_integer: true }
  validates :name_on_card, length: { maximum: 50 }, format: { with: ONLY_LETTERS, message: I18n.t('only_letters') }
  #validates :mm_yy, format: { with: /\A(0{1}([0-9]){1}|1{1}([0-2]){1})\/\d{2}\z/, message: 'the expiration date must be MM/YY' }
  validates :cvv, length: { in: 3..4 }

  def save
    return false unless valid?

    persist!
    true
  end

  private

  def persist!
    @card = Card.create!(card_params)
  end

  def card_params
    {
      card_number: card_number,
      name_on_card: name_on_card,
      mm_yy: mm_yy,
      cvv: cvv,
      order_id: order_id
    }
  end
end
