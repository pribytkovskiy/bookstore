class OrdersController < InheritedResources::Base
  before_action :authenticate_user!

  ORDER_STATE = { cart: :cart, address: :address, delivery: :delivery_method, payment: :payment, confirmation: :confirmation }

  def index
    @orders = Order.sort_order(current_user.id, params[:sort_order])
  end

  def show
    set_instance
    render @order.state.to_sym
    set_in_queued
  end

  def update
    session[:check] = params[:check]
    set_instance
    if @result.failure?
      render @order.state.to_sym
    else
      redirect_to order_path
    end
  end

  def edit
    @order.state = params[:state]
    @order.save
    redirect_to order_path
  end

  private

  def set_instance
    @result = Checkout::Checkout.call(params)
    set_order
    @address = @result.address
    @card = @result.card_inst
    @delivery = @result.delivery_inst
    flash.now[:message] = t(@result.message) if @result.failure?
  end

  def set_in_queued
    @order.add_in_queued! if @order.state == 'complete'
  end
end
