class AddressOrder
  include Interactor

  def call
    context.address = AddressForm.new(context.address_form.permit!)
    if context.address.save
      context.order = Order.find(context.params.id).add_delivery_method!
      context.order.save
    else
      context.fail!(message: I18n.t('interactors.errors.address'))
    end
  end
end
