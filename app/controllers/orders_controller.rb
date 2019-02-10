class OrdersController < InheritedResources::Base
  before_action :authenticate_user!

  ORDER_STATE = { address: :address, delivery: :delivery_method, payment: :payment, confirmation: :confirmation }

  def show
    @address = SetUserAddressToOrder.call(current_user: current_user, order: @order).address if @order.cart?
    render @order.state.to_sym
  end

  def update # check, copy params?
    session[:check] = params[:check]
    result = Checkout.call(params)
    @address = result.address
    @card = result.card
    flash.now[:message] = t(result.message) if result.failure?
    render @order.state.to_sym
  end
end
