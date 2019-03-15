class Checkout::ShowOrder
  include Interactor

  def call
    set_order
    context.billing_address = @order.addresses.billing.last || @order.user.addresses.billing.last || @order.addresses.billing.new
    context.shipping_address = @order.addresses.shipping.last || @order.user.addresses.shipping.last || @order.addresses.shipping.new

    context.delivery = @order.delivery_id || Delivery.new

    context.payment = @order.card || Card.new
  end

  private

  def set_order
    @order = Order.find_by(id: context.id)
  end
end
