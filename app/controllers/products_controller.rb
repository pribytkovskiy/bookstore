class ProductsController < ApplicationController
  include ProductHelper

  def show
    @product = Product.find_by_id(params[:id])
    @reviews = Comment.where(product_id: @product.id, state: 'true')
    set_views(@product)
  end
end
