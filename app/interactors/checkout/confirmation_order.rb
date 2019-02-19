class Checkout::ConfirmationOrder
  include Interactor

  def call
    if context.complete
      context.order = Order.find(context.id)
      context.order.subtotal = context.order.total_price + context.order.delivery.price - context.order.coupon&.price.to_i
      context.order.save
      context.order.add_complete!
    end
  end
end
