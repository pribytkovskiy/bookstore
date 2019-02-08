class PaymentForm
  
  include ActiveModel::Model
  include Virtus.model

  attribute :card_number, String
  attribute :name_on_card, String
  attribute :cvv, Integer
  attribute :mm_yy, String

  validates :card_number, :name_on_card, :mm_yy, :cvv, presence: true
  validates :card_number, length: { minimum: 10 }, format: { with: /\A[0-9]+\z/, message: 'please enter a valid credit card number' }
  validates :name_on_card, length: { maximum: 50 }, format: { with: /\A[a-zA-Z]+\z/, message: 'only allows letters' }
  validates :mm_yy, format: { with: /\A(0{1}([0-9]){1}|1{1}([0-2]){1})\/\d{2}\z/, message: 'the expiration date must be MM/YY' }
  validates :cvv, length: { maximum: 4 }

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      line_items << item
    end
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end

  def total_cupon
    @cupon = Cupon.find(cupon_id)
    @cupon.price
  end

  def total_delivery
    @delivery = Delivery.find(delivery_id)
    @delivery.price
  end

  private

  def persist!
    @order = current_user.orders.build(order_params)
  end
end
