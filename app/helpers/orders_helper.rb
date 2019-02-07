module OrdersHelper
  def adress_has_error?(field)
    @address.errors.include?(field)
  end

  def adress_error_message(field)
    @address.errors.messages[field].first
  end
end
 