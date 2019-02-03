class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id]).decorate
    @reviews = Comment.where(product_id: params[:id], approved: true)
  end
end
