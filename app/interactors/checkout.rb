class Checkout
  include Interactor

  def call
    order = Order.find(context.id)
    case order.state.to_sym
    when OrdersController::ORDER_STATE[:address] then AddressOrder.call(context)
    when OrdersController::ORDER_STATE[:delivery] then DeliveryOrder.call(context)
    when OrdersController::ORDER_STATE[:payment] then PaymentOrder.call(context)
    when OrdersController::ORDER_STATE[:confirmation] then ConfirmationOrder.call(context)
    end
  end
end
