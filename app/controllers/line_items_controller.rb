class LineItemsController < ApplicationController
  TYPE_UPDATE = { plus: :plus, minus: :minus }

  def create
    @cart.add_product(params[:product_id])
    redirect_to params[:redirect_to]
  end

  def update
    @cart.add_product(params[:product_id]) if params[:type] == TYPE_UPDATE[:plus]
    @cart.del_product(params[:product_id]) if params[:type] == TYPE_UPDATE[:minus]
    redirect_to params[:redirect_to]
  end

  def destroy
    @cart.destroy_product(params[:product_id])
    redirect_to cart_path
  end
end
