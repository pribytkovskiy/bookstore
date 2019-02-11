class SetUserAddressToOrder
  include Interactor

  def call
    add_user_to_order
    context.order.add_address!
    if context.current_user.addresses.billing.empty?
      context.address = AddressForm.new
    else
      @address_billing = context.current_user.addresses.search_billing.first
      @address_shipping = context.current_user.addresses.search_shipping.first
      context.address = AddressForm.new(address_params)
    end
  end

  private

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

  def add_user_to_order
    context.order.user_id = context.current_user.id
    context.order.save
  end
end
