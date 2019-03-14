class Checkout::ShowOrder
  include Interactor

  def call
    set_order
    context.address = AddressForm.new(context)

    context.delivery = @order.delivery_id || Delivery.new

    context.payment = @order.card || Card.new
  end

  private

  def set_order
    @order = Order.find_by(id: context.order_id)
    context.id = @order.id
  end
end
