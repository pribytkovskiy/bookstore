class Checkout::AddressOrder
  include Interactor

  def call
    if context.address_form
      set_order_address_from_form
    else
      context.addresses = Order.find(context.id).addresses
      return set_order_address_from_order unless context.addresses.empty?

      context.address = Checkout::SetUserAddressToOrder.call(id: context.id).address
    end
  end

  private

  def set_order_address_from_order
    @address_billing = context.addresses.billing.first
    @address_shipping = context.addresses.shipping.first
    context.address = AddressForm.new(params)
  end

  def set_order_address_from_form
    context.address = AddressForm.new(context.address_form)
    save_address
  end

  def save_address
    if context.address.save
      context.order = Order.find(context.id)
      context.order.add_delivery_method!
    else
      context.fail!(message: I18n.t('interactors.errors.address'))
    end
  end
end
