class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  before_action :set_i18n_locale_from_params
  before_action :set_order, :set_categories, :set_user_for_order

  protected

  def set_i18n_locale_from_params
    return unless params[:locale]

    return I18n.locale = params[:locale] if I18n.available_locales.include?(params[:locale].to_sym)

    flash.now[:notice] = I18n.t('translation_no', locale: params[:locale])
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def authenticate_admin!
    if current_user
      redirect_to new_user_session_path unless current_user.role?(:admin)
    else
      redirect_to new_user_session_path
    end
  end

  private

  def set_categories
    @labels = Category.all # rubocop:disable Naming/MemoizedInstanceVariableName
  end

  def set_order
    @order = Order.active_order(session[:order_id]).decorate
  rescue ActiveRecord::RecordNotFound
    @order = Order.create
    session[:order_id] = @order.id
  end

  def set_user_for_order
    return unless user_signed_in? && @order.user_id.nil?

    @order.update(user: current_user)
  end
end
