class UpdateOrderItem
  include Interactor

  def call
    set_current_item
    case context.type
    when OrderItemsController::COMMANDS[:add] then @current_item.increment!(:quantity) if context.success?
    when OrderItemsController::COMMANDS[:delete] then decrement_current_item if context.success?
    end
  end

  private

  def decrement_current_item
    if @current_item
      return @current_item.decrement!(:quantity) if @current_item.quantity > 1
      
      @current_item.destroy
    end
  end

  def set_current_item
    context.fail!(message: I18n.t('interactors.errors.current_item_failure')) unless @current_item = OrderItem.find(context.id)
  end
end
