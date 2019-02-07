class OrdersController < InheritedResources::Base
  before_action :authenticate_user!

  ORDER_STATE = { address: :address, delivery: :delivery, payment: :payment, confirmation: :confirmation }

  def show
    set_user_address
    render ORDER_STATE[:address]
  end

  def update
    result = Checkout.call(params)
    flash.now[:message] = t(result.message) if result.failure?
    render result.render
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone)
  end

  def set_user_address
    @address_billing = current_user.addresses.billing.empty? ? Address.new(type: :billing) : current_user.addresses.billing
    @address_shipping = current_user.addresses.shipping.empty? ? Address.new(type: :shipping) : current_user.addresses.shipping
  end
end
