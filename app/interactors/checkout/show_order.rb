class Checkout::ShowOrder
  include Interactor

  def call
    set_order
    context.billing_address = set_billing_address
    context.shipping_address = set_shipping_address
    context.delivery = Delivery.find_by(id: @order.delivery_id) || Delivery.new
    context.card = Card.find_by(id: @order.card) || Card.new
  end

  private

  def set_order
    @order = Order.find_by(id: context.id)
  end

  def set_billing_address
    @order.addresses.billing.last || @order.user.addresses.billing.last || @order.addresses.billing.new
  end

  def set_shipping_address
    @order.addresses.shipping.last || @order.user.addresses.shipping.last || @order.addresses.shipping.new
  end
end
