class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    set_address
  end

  def update
    set_address
    if @result.failure?
      render :index
    else
      redirect_to settings_path(user_id: current_user.id)
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

  def set_address
    @result = AddressUser.call(params)
    @address = @result.address
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :reset_password_token)
  end
end
