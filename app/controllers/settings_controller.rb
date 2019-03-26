class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @billing_address = set_billing_address
    @shipping_address = set_shipping_address
  end

  def create
    form_address(params)
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

  def set_billing_address
    current_user.addresses.billing.last || current_user.addresses.billing.new
  end

  def set_shipping_address
    current_user.addresses.shipping.last || current_user.addresses.shipping.new
  end

  def form_address(params)
    @billing_address = AddressForm.new(params[:billing].permit!)
    if params[:check]
      @shipping_address = AddressForm.new(params[:billing].permit!)
      @shipping_address.check = true
    else
      @shipping_address = AddressForm.new(params[:shipping].permit!)
    end
  end
end
