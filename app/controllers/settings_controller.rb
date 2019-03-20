class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @billing_address = current_user.addresses.billing.last || current_user.addresses.billing.new
    @shipping_address = current_user.addresses.shipping.last || current_user.addresses.shipping.new
  end

  def create
    @billing_address = AddressForm.new(params[:billing].permit!)
    @shipping_address = AddressForm.new(params[:shipping].permit!)
    if @billing_address.save && @shipping_address.save
      redirect_to settings_path(user_id: current_user.id)
    else
      render :index
    end
  end

  def update_password
    if current_user.update(user_params)
      bypass_sign_in(current_user)
      redirect_to store_path
    else
      redirect_to settings_path(params)
    end
  end

  def destroy
    current_user.soft_delete
    sign_out
    redirect_to after_sign_out_path_for(:user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :reset_password_token)
  end
end
