class OrdersController < ApplicationController
  def index
    @orders = Order.sort_order(current_user.id, params[:sort_order])
  end

  def show
    @order = Order.find_by(id: params[:id]).decorate
  end
end
