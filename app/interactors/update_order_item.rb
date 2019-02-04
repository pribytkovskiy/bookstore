class UpdateOrderItem
  include Interactor

  def call
    set_current_item
    case context.type
    when OrderItemsController::COMMANDS[:add] then @current_item.increment!(:quantity) if context.success?
    when OrderItemsController::COMMANDS[:delete] then @current_item.decrement!(:quantity) if context.success?
    end
  end

  private

  def set_current_item
    context.fail!(message: "current_item.failure") unless @current_item = OrderItem.find(context.id)
  end
end
