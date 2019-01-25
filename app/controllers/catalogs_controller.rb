class CatalogsController < ApplicationController
  include Pagy::Backend

  NAME_DEFAULT_PARAM_SORT = 'Newest first'

  def show
    @categories = Category.all
    @name_sort = params[:name_sort] ? params[:name_sort] : NAME_DEFAULT_PARAM_SORT
    session[:category] = params[:category_id] if params[:category_id]
    @pagy, @products = pagy(Product.sort_product(params, session))
  end
end
