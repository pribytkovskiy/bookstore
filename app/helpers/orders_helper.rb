module OrdersHelper
  PARAMS = %w(first_name last_name address city zip country phone).freeze

  def adress_has_error?(field)
    current_order.errors.include?(field)
  end

  def adress_error_message(field)
    current_order.errors.messages[field][0]
  end

  def copy_params
    PARAMS.each do |param|
      eval("current_order.shipping_#{param} = current_order.#{param}")
    end
  end
end
 