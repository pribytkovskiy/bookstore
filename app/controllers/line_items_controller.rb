class CartsController < ApplicationController
  def index
    set_line_item(params[:product_id])
    redirect_to params[:redirect_to]
  end

private

  def set_line_item(id)
    product = Product.find(id)
    @line_item = @cart.add_product(product.id)
    @line_item.save
  end
end
