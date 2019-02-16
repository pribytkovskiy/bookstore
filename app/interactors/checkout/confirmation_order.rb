class Checkout::ConfirmationOrder
  include Interactor

  def call
    context.order = Order.find(context.id)
    context.order.subtotal = context.order.total_price + context.order.delivery.price - context.order.coupon&.price.to_i
    context.order.save
    context.order.add_in_queued!
  end
end
