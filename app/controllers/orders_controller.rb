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

  def set_user_address
    @address_billing = current_user.addresses.billing.empty? ? Address.billing.new : current_user.addresses.search_billing.first
    @address_shipping = current_user.addresses.shipping.empty? ? Address.shipping.new : current_user.addresses.search_shipping
  end
end
