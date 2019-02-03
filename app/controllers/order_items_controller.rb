class OrderItemsController < ApplicationController
  TYPE_UPDATE = { plus: :plus, minus: :minus }

  def create
    @order.add_product(params[:product_id])
    redirect_to params[:redirect_to]
  end

  def update
    @order.add_product(params[:product_id]) if params[:type] == TYPE_UPDATE[:plus]
    @order.del_product(params[:product_id]) if params[:type] == TYPE_UPDATE[:minus]
    redirect_to params[:redirect_to]
  end

  def destroy
    @order.destroy_product(params[:product_id])
    redirect_to cart_path
  end
end
