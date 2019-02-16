class Checkout::AddressOrder
  include Interactor

  def call
    context.address = AddressForm.new(context.address_form.permit!)
    if context.address.save
      context.order = Order.find(context.id)
      context.order.add_delivery_method!
    else
      context.fail!(message: I18n.t('interactors.errors.address'))
    end
  end
end
