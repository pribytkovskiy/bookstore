module OrdersHelper
  def adress_has_error?(field)
    #@address_billing.errors.include?(field)
  end

  def adress_error_message(field)
    #@address_billing.errors.messages[field].first
  end
end
 