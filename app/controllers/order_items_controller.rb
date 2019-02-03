class OrderItemsController < ApplicationController
  COMMANDS = { add: 'add', delete: 'delete', destroy: 'destroy' }

  def create
    SetOrderItem.call(product_id: params[:product_id], command: COMMANDS[:add], quantity: params[:quantity], order: @order)
    redirect_to params[:redirect_to]
  end

  def update
    SetOrderItem.call(item: params[:item], command: params[:type], quantity: params[:quantity])
    redirect_to params[:redirect_to]
  end

  def destroy
    SetOrderItem.call(product_id: params[:product_id], command: COMMANDS[:destroy], order: @order)
    redirect_to cart_path
  end
end
