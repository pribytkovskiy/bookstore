class Checkout::UpdateOrder
  include Interactor

  def call
    case context.step.to_sym
    when CheckoutController::ORDER_STATE[:address] then address
    when CheckoutController::ORDER_STATE[:delivery] then delivery
    when CheckoutController::ORDER_STATE[:payment] then payment
    when CheckoutController::ORDER_STATE[:confirmation] then confirmation
    end
  end

  private

  def address
    set_order

    context.billing_address = AddressForm.new(context.billing.permit!)
    if context.check
      context.shipping_address = AddressForm.new(context.billing.permit!)
    else
      context.shipping_address = AddressForm.new(context.shipping.permit!)
    end

    return if context.billing_address.save && context.shipping_address.save
    
    context.fail!(message: I18n.t('interactors.errors.address'), render: :address)
  end

  def delivery
    set_order
    @order.delivery_id = context.delivery[:id]
    return if @order.save
    
    context.fail!(message: I18n.t('interactors.errors.delivery', render: :delivery))
  end

  def payment
    set_order
    context.card = PaymentForm.new(card_params)
    if context.card.save
      @order.card_id = context.card.card.id 
      @order.save
    else
      context.fail!(message: I18n.t('interactors.errors.payment'), render: :payment)
    end
  end

  def confirmation
    set_order
    @order.subtotal = @order.total_price + @order.delivery.price - @order.coupon&.price.to_i
    @order.add_complete!
  end

  def set_order
    @order ||= Order.find_by(id: context.id)
  end

  def card_params
    {
      card_number: context.card_number,
      name_on_card: context.name_on_card,
      mm_yy: context.mm_yy,
      cvv: context.cvv,
      order_id: context.id
    }
  end
end
