class PaymentOrder
  include Interactor

  def call
    unless context.order&.key?('delivery_id')
      context.card_inst = PaymentForm.new(card_number: context.card_number, name_on_card: context.name_on_card, mm_yy: context.mm_yy, cvv: context.cvv)
      if context.card_inst.save
        context.order = Order.find(context.id)
        context.order.add_confirmation!
        context.order.save
      else
        context.fail!(message: I18n.t('interactors.errors.delivery'))
      end
    else
      context.card_inst = PaymentForm.new
    end
  end
end
