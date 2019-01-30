class OrdersController < InheritedResources::Base
  before_action :authenticate_user!

  PARAMS = %w(first_name last_name address city zip country phone).freeze
  ORDER_STATE = { cart: :cart, address: :address, delivery: :delivery, payment: :payment, confirmation: :confirmation }

  def show
    redirect_to store_url, notice: "Your cart is empty" unless @cart.line_items
    # check_state
    render params[:id].to_sym
  end

  def create
    case params[:state].to_sym
    when ORDER_STATE[:address] then session[:order_id] = Checkout::CreateOrder.call(@cart, current_user.id, params[:coupon_id]).id
    when ORDER_STATE[:delivery]
      render 'orders/address' and return if !current_user.update_attributes(user_params)
      copy_user_params if current_user.check == true
      current_user.save
      Checkout::UpdateAddressOrder.call(current_order, current_user)
    when ORDER_STATE[:payment] then Checkout::DeliveryOrder.call(delivery_params)
    when ORDER_STATE[:confirmation] then Checkout::PaymentOrder.call(payment_params)
    when ORDER_STATE[:home] then Checkout::ConfirmationOrder.call(confirmation_params)
    end
    render params[:state].to_sym
  end

  private

  def user_params
    if params[:check] == 'true'
      current_user.check = true
      current_user.save(validate: false)
      params.require(:user).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone)
    else
      current_user.check = false
      current_user.save(validate: false)
      params.require(:user).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :shipping_first_name, :shipping_last_name, :shipping_address, :shipping_city, :shipping_zip, :shipping_country, :shipping_phone)
    end
  end

  def copy_user_params
    PARAMS.each do |param|
      eval("current_user.shipping_#{param} = current_user.#{param}")
    end
  end
end
