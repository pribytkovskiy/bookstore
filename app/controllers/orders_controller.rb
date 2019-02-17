class OrdersController < InheritedResources::Base
  before_action :authenticate_user!

  ORDER_STATE = { address: :address, delivery: :delivery_method, payment: :payment, confirmation: :confirmation }

  def index
    @orders = Order.where(user_id: current_user)
  end

  def show
    set_instance
    render @order.state.to_sym
  end

  def update
    session[:check] = params[:check]
    set_instance
    if @result.failure?
      render @order.state.to_sym
    else
      redirect_to show
    end
  end

  def edit
    @order.state = params[:state]
    @order.save
    redirect_to action: 'update'
  end

  private

  def set_instance
    @result = Checkout.call(params)
    @address = @result.address
    @card = @result.card_inst
    flash.now[:message] = t(@result.message) if @result.failure?
  end
end
