class OrdersController < InheritedResources::Base
  before_action :authenticate_user!

  ORDER_STATE = { address: :address, delivery: :delivery, payment: :payment, confirmation: :confirmation }

  def show
    @address = current_user.addresses
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
end
