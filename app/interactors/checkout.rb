class Checkout
  include Interactor

  def call
    order = Order.find(context.id)
    case order.state.to_sym
    when OrdersController::ORDER_STATE[:address] then Checkout::AddressOrder.call(context)
    when OrdersController::ORDER_STATE[:delivery] then Checkout::DeliveryOrder.call(context)
    when OrdersController::ORDER_STATE[:payment] then Checkout::PaymentOrder.call(context)
    when OrdersController::ORDER_STATE[:confirmation] then Checkout::ConfirmationOrder.call(context)
    end
  end
end
