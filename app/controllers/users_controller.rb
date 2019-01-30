class UsersController < ApplicationController
  PARAMS = %w(first_name last_name address city zip country phone).freeze

  def update
    copy_params if current_user.check == true
    current_user.update_attributes(user_params)
    redirect_to proc { orders_path(state: :delivery) }
  end

  private

  def copy_params
    PARAMS.each do |param|
      eval("@order.shipping_#{param} = @order.#{param}")
    end
  end

  def user_params
    if params[:check] == 'true'
      current_user.check = true
      current_user.save(validate: false)
      params.require(:user).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone)
    else
      current_user.check = false
      current_user.save(validate: false)
      params.require(:user).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :shipping_first_name, :shipping_last_name, :shipping_address, :shipping_city, :shipping_zip, :shipping_country, :shipping_phone)
    end
  end
end
