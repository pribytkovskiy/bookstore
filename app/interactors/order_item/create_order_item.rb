class OrderItem::CreateOrderItem
  include Interactor

  def call
    if current_item = Order.find(context.order_id).order_items.find_by(product_id: context.product_id)
      add_current_item_quantity(current_item)
      current_item.increment!(:quantity) unless context.quantity
    else
      create_order_item
    end
  end

  private

  def create_order_item
    if current_item = OrderItem.create(product_id: context.product_id, order_id: context.order_id)
      current_item.quantity = context.quantity.to_i if context.quantity
      current_item.save
    else
      context.fail!(message: I18n.t('interactors.errors.create_order_item_failure'))
    end
  end

  def add_current_item_quantity(current_item)
    if current_item.quantity = current_item.quantity + context.quantity.to_i
      current_item.save
    else
      context.fail!(message: I18n.t('interactors.errors.add_current_item_quantity'))
    end
  end
end
