module SettingsHelper
  def adress_has_error?(field)
    @billing_address.errors.include?(field)
  end

  def adress_error_message(field)
    @billing_address.errors.messages[field].first
  end
end
