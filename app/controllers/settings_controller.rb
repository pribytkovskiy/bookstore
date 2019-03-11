class SettingsController < ApplicationController
  authorize_resource :class => false
  before_action :authenticate_user!

  def index
    @result = AddressUser.call(params)
    @address = @result.address
  end

  def update
    @result = AddressUser.call(address_params)
    @address = @result.address
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

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :reset_password_token)
  end

  def address_params
    { address_form: {
        first_name: params[:address_form][:first_name],
        last_name: params[:address_form][:last_name],
        address: params[:address_form][:address],
        city: params[:address_form][:city],
        zip: params[:address_form][:zip],
        country: params[:address_form][:country],
        phone: params[:address_form][:phone],
        shipping_first_name: params[:address_form][:shipping_first_name],
        shipping_last_name: params[:address_form][:shipping_last_name],
        shipping_address: params[:address_form][:shipping_address],
        shipping_city: params[:address_form][:shipping_city],
        shipping_zip: params[:address_form][:shipping_zip],
        shipping_country: params[:address_form][:shipping_country],
        shipping_phone: params[:address_form][:shipping_phone],
        user_id: params[:user_id],
        check: params[:check]
      },
      user_id: params[:user_id],
      id: params[:id]
    }
  end
end
