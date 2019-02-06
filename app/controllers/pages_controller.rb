class PagesController < ApplicationController
  include Pagy::Backend

  QUANTITY_BESTSELLERS = 4
  LATEST_DEFAULT_QUANTITY = 2

  def home
    @favorites = FavoriteProducts.call(
      latest_default_quantity: LATEST_DEFAULT_QUANTITY, bestsellers_default_quantity: QUANTITY_BESTSELLERS
    )
  end

  def catalog
    session[:category_id] = params[:category_id] if params[:category_id]
    @sort_products = SortProducts.call(params: params, category_id: session[:category_id])
    @pagy, @products = pagy(@sort_products.products)
  end

  def cart
    redirect_to store_url, notice: t('.cart_empty') if check_order_items?
  end

  private

  def check_order_items?
    @order.order_items.empty?
  end
end
