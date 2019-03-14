class Checkout::UpdateOrder
  include Interactor

  def call
    case context.step.to_sym
    when CheckoutController::ORDER_STATE[:address] then address
    when CheckoutController::ORDER_STATE[:delivery_method] then delivery
    when CheckoutController::ORDER_STATE[:payment] then payment
    when CheckoutController::ORDER_STATE[:confirmation] then confirmation
    end
  end

  private

  def address
    set_order
    if context.address.save
      @order.add_delivery_method!
    else
      context.fail!(message: I18n.t('interactors.errors.address'), render: :address)
    end
  end

  def delivery
    set_order
    @order.delivery_id = context.delivery[:id]
    if @order.save
      @order.add_payment!
    else
      context.fail!(message: I18n.t('interactors.errors.delivery'))
    end
  end

  def payment
    set_order
    context.card = PaymentForm.new(context)
    if context.card.save
      @order.add_confirmation!
    else
      context.fail!(message: I18n.t('interactors.errors.payment'))
    end
  end

  def confirmation
    set_order
    @order.add_complete!
  end

  def set_order
    @order = Order.find_by(id: context.order_id)
  end
end
