class Checkout::ShowOrder
  include Interactor

  def call
    set_order
    context.shipping_address = AddressForm.new(@order.addresses.shipping.last) || AddressForm.new(@order.user.addresses.shipping.last) || AddressForm.new
    context.billing_address = AddressForm.new(@order.addresses.billing.last) || AddressForm.new(@order.user.addresses.billing.last) || AddressForm.new

    context.delivery = @order.delivery_id || Delivery.new

    context.payment = @order.card || Card.new
  end

  private

  def set_order
    @order = Order.find_by(id: context.order_id)
    context.id = @order.id
  end
end
