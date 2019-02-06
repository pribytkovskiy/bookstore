class OrdersController < InheritedResources::Base
  before_action :authenticate_user!

  ORDER_STATE = { address: :address, delivery: :delivery, payment: :payment, confirmation: :confirmation }

  def update

    render params[:redirect_to]
  end

  private

  def user_params
      params.require(:user).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone)
  end
end
