class CartsController < ApplicationController
  def update
    @coupon = Coupon.find_by_number(params[:coupon][:number])
    render :show
  end
end
