class OrderItemsController < ApplicationController
  load_and_authorize_resource
  
  COMMANDS = { add: 'add', delete: 'delete' }

  def create
    result = OrderItem::CreateOrderItem.call(params)
    flash.now[:message] = t(result.message) if result.failure?
    redirect_to params[:redirect_to] if params[:redirect_to]
  end

  def update
    result = OrderItem::UpdateOrderItem.call(params)
    flash.now[:message] = t(result.message) if result.failure?
    redirect_to params[:redirect_to]
  end

  def destroy
    result = OrderItem::DestroyOrderItem.call(params)
    flash.now[:message] = t(result.message) if result.failure?
    redirect_to cart_path
  end
end
