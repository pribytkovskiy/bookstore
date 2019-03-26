class OrderItem::CreateOrderItem
  include Interactor

  def call
    current_item = Order.find_by(id: context.order_id).order_items.find_by(product_id: context.product_id)
    if current_item
      add_current_item_quantity(current_item)
      current_item.increment!(:quantity) unless context.quantity
    else
      create_order_item
    end
  end

  private

  def create_order_item
    current_item = OrderItem.create(product_id: context.product_id, order_id: context.order_id)
    if current_item
      current_item.update(quantity: context.quantity.to_i.abs) if context.quantity
    else
      context.fail!(message: I18n.t('interactors.errors.create_order_item_failure'))
    end
  end

  def add_current_item_quantity(current_item)
    if current_item.quantity
      quantity = current_item.quantity + context.quantity.to_i.abs
      current_item.update(quantity: quantity)
    else
      context.fail!(message: I18n.t('interactors.errors.add_current_item_quantity'))
    end
  end
end
