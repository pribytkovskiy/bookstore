class AddressUser
  include Interactor

  def call
    set_user
    return create_user_address if context.address_form

    set_user_address
  end

  private

  def set_user_address
    if context.current_user.addresses.empty?
      context.address = AddressForm.new
    else
      @address_billing = context.current_user.addresses.search_billing.first
      @address_shipping = context.current_user.addresses.search_shipping.first
      context.address = AddressForm.new(address_params)
    end
  end

  def create_user_address
    context.address = AddressForm.new(context.address_form.permit!)
    context.fail!(message: I18n.t('interactors.errors.address')) unless context.address.save
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

  def set_user
    context.current_user = User.find(context.user_id)
  end
end
