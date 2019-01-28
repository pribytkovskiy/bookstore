class LineItemsController < ApplicationController
  def create
    @cart.add_product(params[:product_id])
    redirect_to params[:redirect_to]
  end
end
