class OrderItemsController < ApplicationController
  COMMANDS = { add: 'add', delete: 'delete' }

  def create
    result = CreateOrderItem.call(params)
    flash.now[:message] = t(result.message) if result.failure?
    redirect_to params[:redirect_to] if params[:redirect_to]
  end

  def update
    result = UpdateOrderItem.call(params)
    flash.now[:message] = t(result.message) if result.failure?
    redirect_to params[:redirect_to]
  end

  def destroy
    result = DestroyOrderItem.call(params)
    flash.now[:message] = t(result.message) if result.failure?
    redirect_to cart_path
  end
end
