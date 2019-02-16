class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id]).decorate
    @reviews = Comment.where(product_id: params[:id], approved: true)
    save_my_previous_url
  end

  private

  def save_my_previous_url
    session[:return_to] ||= request.referer
  end
end
