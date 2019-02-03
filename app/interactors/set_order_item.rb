class SetOrderItem
  include Interactor

  def call
    case
    when OrderItemsController::COMMANDS[:add] then add_product
    when OrderItemsController::COMMANDS[:delete] then delete_product
    when OrderItemsController::COMMANDS[:destroy] then destroy_product
    end
  end

  private

  def add_product
    set_current_item
    return @current_item.increment!(:quantity) if @current_item

    @current_item = OrderItem.create(product_id: context.product_id, order: context.order)
    @current_item.quantity = context.quantity.to_i
    @current_item.save
  end

  def delete_product
    set_current_item
    return @current_item.decrement!(:quantity) if @current_item.quantity > 1

    @current_item.destroy
  end

  def destroy_product
    set_current_item
    @current_item.destroy
  end

  def set_current_item
    @current_item = OrderItem.find_by(product_id: context.product_id)
  end
end
