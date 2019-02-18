class Checkout::PaymentOrder
  include Interactor

  def call
    context.order = Order.find(context.id)
    return set_new_card if !context.order.card_id && !context.card_number

    set_card
  end

  private

  def set_card
    return context.card_inst = Card.find(context.order.card_id) if context.order.card_id && !context.card_number

    save_card
  end

  def set_new_card
    context.card_inst = PaymentForm.new
  end

  def save_card
    context.card_inst = PaymentForm.new(card_number: context.card_number, name_on_card: context.name_on_card, mm_yy: context.mm_yy, cvv: context.cvv, order_id: context.id)
    if context.card_inst.save
      context.order.card_id = Card.where(order_id: context.id).last.id
      context.order.save
      context.order.add_confirmation!
    else
      context.fail!(message: I18n.t('interactors.errors.payment'))
    end
  end
end
