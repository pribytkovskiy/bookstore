class OrderPresenter < BasePresenter
  presents :order

  def number
    "R#{order.id}"
  end

  def time
    order.updated_at.strftime("%B %d, %Y")
  end

  def price
    order.subtotal - order.total_cupon
  end

  def present(info, current_user)
    case info
    when 'email'    
      "#{current_user.first_name} #{current_user.email}"
    when 'name'   
      "#{current_user.first_name} #{current_user.last_name}"
    when 'city'   
      "#{current_user.shipping_city} #{current_user.shipping_zip}"
    when 'phone'   
      "Phone #{current_user.phone}"
    else
      nil
    end
  end
end