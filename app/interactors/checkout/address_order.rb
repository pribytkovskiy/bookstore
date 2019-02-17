class Checkout::AddressOrder
  include Interactor

  def call
    if context.address_form
      context.address = AddressForm.new(context.address_form.permit!)
      save_address
    else
      context.address = Checkout::SetUserAddressToOrder.call(context.id).address
    end
  end

  private

  def save_address
    if context.address.save
      context.order = Order.find(context.id)
      context.order.add_delivery_method!
    else
      context.fail!(message: I18n.t('interactors.errors.address'))
    end
  end
end
