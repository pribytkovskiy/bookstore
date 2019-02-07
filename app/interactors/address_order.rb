class AddressOrder
  include Interactor

  def call
    Order.find()
    if order = order.update_attributes(context)
      context.render = OrdersController::ORDER_STATE[:delivery]
    else
      context.fail!(message: I18n.t('interactors.errors.address'))
      context.render = OrdersController::ORDER_STATE[:address]
    end
  end
end