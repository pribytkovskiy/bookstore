class Checkout::DeliveryOrder
  include Interactor

  def call
    context.order = Order.find(context.id)
    return set_new_delivery_method if !context.order.delivery_id && !context.delivery

    set_delivery_method
  end

  private

  def set_delivery_method
    context.delivery_inst = Delivery.find_by(id: context.order.delivery_id)
    return context.delivery_inst if context.order.delivery_id && !context.delivery

    context.delivery_inst = context.delivery[:id]
    context.order.delivery_id = context.delivery_inst
    save_delivery
  end

  def set_new_delivery_method
    context.delivery_inst = Delivery.new
  end

  def save_delivery
    if context.order.save
      context.order.add_payment!
    else
      context.fail!(message: I18n.t('interactors.errors.delivery'))
    end
  end
end
