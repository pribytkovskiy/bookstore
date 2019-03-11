class Checkout::Checkout
  include Interactor

  def call
    order = Order.find(context.id)
    case order.state.to_sym
    when OrdersController::ORDER_STATE[:cart] then Checkout::AddressOrder.call(context)
    when OrdersController::ORDER_STATE[:address] then Checkout::AddressOrder.call(address_params)
    when OrdersController::ORDER_STATE[:delivery] then Checkout::DeliveryOrder.call(context)
    when OrdersController::ORDER_STATE[:payment] then Checkout::PaymentOrder.call(context)
    when OrdersController::ORDER_STATE[:confirmation] then Checkout::ConfirmationOrder.call(context)
    end
  end

  private
  
    def address_params
      if context.address_form
        { address_form: {
            first_name: context.address_form[:first_name],
            last_name: context.address_form[:last_name],
            address: context.address_form[:address],
            city: context.address_form[:city],
            zip: context.address_form[:zip],
            country: context.address_form[:country],
            phone: context.address_form[:phone],
            shipping_first_name: context.address_form[:shipping_first_name],
            shipping_last_name: context.address_form[:shipping_last_name],
            shipping_address: context.address_form[:shipping_address],
            shipping_city: context.address_form[:shipping_city],
            shipping_zip: context.address_form[:shipping_zip],
            shipping_country: context.address_form[:shipping_country],
            shipping_phone: context.address_form[:shipping_phone],
            user_id: context.user_id,
            order_id: context.id,
            check: context.check
          },
          id: context.id,
          order_id: context.id
        }
      else
        context
      end
    end
end
