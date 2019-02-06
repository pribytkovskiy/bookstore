class OrdersController < InheritedResources::Base
  before_action :authenticate_user!

  ORDER_STATE = { address: :address, delivery: :delivery, payment: :payment, confirmation: :confirmation }

  def update
    set_coupon if params[:order]
    result = Checkout.call(params)
    flash.now[:message] = t(result.message) if result.failure?
    render params[:redirect_to] if params[:redirect_to]
  end

  private

  def set_coupon
    if coupon = Coupon.find_by(number: params[:order][:number].to_i)
      @order.coupon_id = coupon.id
      @order.save
      redirect_to cart_path
    else
      flash.now[:message] = 'No coupon'
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone)
  end

  def coupon_params
    
  end
end
