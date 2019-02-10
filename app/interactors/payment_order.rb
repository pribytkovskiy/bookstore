class PaymentOrder
  include Interactor

  def call
    context.card = PaymentForm.new
    if context.card.save
      context.order = Order.find(context.params.id).add_confirmation!
      context.order.save
    else
      context.fail!(message: I18n.t('interactors.errors.delivery'))
    end
  end
end
