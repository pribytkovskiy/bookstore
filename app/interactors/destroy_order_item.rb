class DestroyOrderItem
  include Interactor

  def call
    context.fail!(message: "current_item.failure") unless current_item = OrderItem.find(context.id)
    current_item.destroy
  end
end
