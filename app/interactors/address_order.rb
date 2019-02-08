class AddressOrder
  include Interactor

  def call
    @address = AddressForm.new(context.params) # address + order_id
    if @address.save
      context.render = OrdersController::ORDER_STATE[:delivery]
    else
      context.fail!(message: I18n.t('interactors.errors.address'))
      context.render = OrdersController::ORDER_STATE[:address]
    end
  end
end
