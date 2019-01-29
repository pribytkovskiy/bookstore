class OrdersController < InheritedResources::Base
  before_action :authenticate_user!

  ORDER_STATE = { cart: :cart, address: :address, delivery: :delivery, payment: :payment, confirmation: :confirmation }

  def show
    redirect_to store_url, notice: "Your cart is empty" unless @cart.line_items
    # check_state
    render params[:id].to_sym
  end

  def create
    case params[:state].to_sym
    when ORDER_STATE[:address] then @order = Checkout::CreateOrder.call(ORDER_STATE[:address], current_user.id, params[:coupon_id])
    when ORDER_STATE[:delivery] then Checkout::AddressOrder.call(address_params)
    when ORDER_STATE[:payment] then Checkout::DeliveryOrder.call(delivery_params)
    when ORDER_STATE[:confirmation] then Checkout::PaymentOrder.call(payment_params)
    when ORDER_STATE[:home] then Checkout::ConfirmationOrder.call(confirmation_params)
    end
    render params[:state].to_sym
  end

  private

  def address_params
    params.require(:order).permit(
      :first_name, :last_name, :address, :city,
      :zip, :country, :phone, :shipping_first_name, :shipping_last_name, 
      :shipping_address, :shipping_city, :shipping_zip, :shipping_country, 
      :shipping_phone
    )
  end
end