class CreateOrderItem
  include Interactor

  def call
    if current_item = Order.find(context.order_id).order_items.find_by(product_id: context.product_id)
      current_item.increment!(:quantity)
    else
      create_order_item
    end
  end

  private

  def create_order_item
    if current_item = OrderItem.create(product_id: context.product_id, order_id: context.order_id)
      current_item.save
    else
      context.fail!(message: "create_order_item.failure")
    end
  end
end
