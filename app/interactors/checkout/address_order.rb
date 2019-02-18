class Checkout::AddressOrder
  include Interactor

  def call
    if context.address_form
      set_order_address_from_form
    else
      context.addresses = Order.find(context.id).addresses
      return set_order_address_from_order if !context.addresses.empty?

      context.address = Checkout::SetUserAddressToOrder.call(id: context.id).address
    end
  end

  private

  def set_order_address_from_order
    @address_billing = context.addresses.billing.first
    @address_shipping = context.addresses.shipping.first
    context.address = AddressForm.new(address_params)
  end

  def set_order_address_from_form
    context.address = AddressForm.new(context.address_form.permit!)
    save_address
  end

  def address_params
    {
      first_name: @address_billing.first_name,
      last_name: @address_billing.last_name,
      address: @address_billing.address,
      phone: @address_billing.phone,
      city: @address_billing.city,
      country: @address_billing.country,
      zip: @address_billing.zip,
      shipping_first_name: @address_shipping.first_name,
      shipping_last_name: @address_shipping.last_name,
      shipping_address: @address_shipping.address,
      shipping_city: @address_shipping.city,
      shipping_country: @address_shipping.country,
      shipping_phone: @address_shipping.phone,
      shipping_zip: @address_shipping.zip,
      check: false
    }
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
