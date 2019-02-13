class CartsController < ApplicationController
  def show
    redirect_to store_url, notice: t('.cart_empty') if check_order_items?
  end

  def update
    if coupon = Coupon.find_by(number: coupon_params)
      @order.coupon_id = coupon.id
      @order.save
    else
      flash.now[:message] = t('.no_coupon')
    end
    redirect_to cart_path
  end

  private

  def check_order_items?
    @order.order_items.empty?
  end

  def coupon_params
    params.require(:order).permit(:number).dig(:number).to_i
  end
end
