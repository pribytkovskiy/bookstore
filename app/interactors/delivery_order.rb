class DeliveryOrder
  include Interactor

  def call
    context.delivery_id = context.order[:delivery_id].to_i
    context.order = Order.find(context.id)
    context.order.delivery_id = context.delivery_id
    if context.order.save
      context.order.add_payment!
      context.card_inst = PaymentForm.new
    else
      context.fail!(message: I18n.t('interactors.errors.delivery'))
    end
  end
end
