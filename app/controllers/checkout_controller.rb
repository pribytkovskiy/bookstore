class CheckoutController < ApplicationController
  before_action :authenticate_user!

  ORDER_STATE = { cart: :cart,
                  address: :address,
                  delivery: :delivery_method,
                  payment: :payment,
                  confirmation: :confirmation }.freeze

  def index
    @orders = Order.sort_order(current_user.id, params[:sort_order])
  end

  def show
    @result = Checkout::ShowOrder.call(params)
    set_instance

    render params[:next_render].to_sym
    set_in_queued
  end

  def update
    session[:check] = params[:check]
    @result = Checkout::UpdateOrder.call(params)
    set_instance

    if @result.failure?
      render @result.render.to_sym
    else
      redirect_to checkout_path(next_render: params[:next_render].to_sym)
    end
  end

  private

  def set_instance
    @billing_address = @result.billing_address
    @shipping_address = @result.shipping_address
    @delivery = @result.delivery
    @card = @result.card
  end

  def set_in_queued
    @order.add_in_queued! if @order.state == 'complete'
  end
end
