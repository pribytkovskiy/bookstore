class ProductsController < ApplicationController
  include Pagy::Backend
  include Pagy::Frontend

  def show
    @categories = Category.all
    @pagy, @products = pagy(Product.all)
  end
end
