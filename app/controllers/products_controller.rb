class ProductsController < ApplicationController
  include Pagy::Backend

  NAME_DEFAULT_PARAM_SORT = 'Newest first'

  def show
    @categories = Category.all
    @name_sort = NAME_DEFAULT_PARAM_SORT || params[:name_sort]
    session[:category] = params[:category_id] || @categories.ids
    @pagy, @products = pagy(Product.sort_product(params, session))
  end
end
