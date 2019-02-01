class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_i18n_locale_from_params
  before_action :set_order, :set_labels

  protected

  def set_i18n_locale_from_params
    return unless params[:locale]

    return I18n.locale = params[:locale] if I18n.available_locales.include?(params[:locale].to_sym)

    flash.now[:notice] = "#{params[:locale]} translation not available"
    logger.error flash.now[:notice]
  end

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def set_order
    @order = Order.find(session[:order_id])
  rescue ActiveRecord::RecordNotFound
    @order = Order.create
    session[:order_id] = @order.id
  end

  def set_labels
    @labels = Category.all
  end
end
