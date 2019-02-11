class PaymentOrder
  include Interactor

  def call
    context.card_inst = PaymentForm.new(card_number: context.card_number, name_on_card: context.name_on_card, mm_yy: context.mm_yy, cvv: context.cvv, order_id: context.id)
    if context.card_inst.save
      context.order = Order.find(context.id)
      context.order.card_id = Card.find_by(order_id: context.id).id
      context.order.save
      context.order.add_confirmation!
    else
      context.fail!(message: I18n.t('interactors.errors.delivery'))
    end
  end
end
