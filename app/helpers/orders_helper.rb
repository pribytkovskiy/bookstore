module OrdersHelper
  def adress_has_error?(field)
    @address.errors.include?(field)
  end

  def adress_error_message(field)
    @address.errors.messages[field].first
  end

  def card_has_error?(field)
    @card.errors.include?(field)
  end

  def card_error_message(field)
    @card.errors.messages[field].first
  end

  def check?
    if session[:check] == 'true'
      true
    elsif session[:check] == 'false'
      false
    end
  end
end
