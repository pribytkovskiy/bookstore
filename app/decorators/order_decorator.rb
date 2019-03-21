class OrderDecorator < Draper::Decorator
  CARD_SYMBOLS = { count_stars: 12, count_card_symbols: 4}

  delegate_all

  def shipping_name
    "#{object.addresses.shipping.first.first_name} #{object.addresses.shipping.first.last_name}"
  end

  def shipping_address
    object.addresses.shipping.first.address
  end

  def shipping_city
    "#{object.addresses.shipping.first.city} #{object.addresses.shipping.first.zip}"
  end

  def shipping_country
    object.addresses.shipping.first.country
  end

  def shipping_phone
    object.addresses.shipping.first.phone
  end

  def billing_name
    "#{object.addresses.billing.first.first_name} #{object.addresses.billing.first.last_name}"
  end

  def billing_address
    object.addresses.billing.first.address
  end

  def billing_city
    "#{object.addresses.billing.first.city} #{object.addresses.billing.first.zip}"
  end

  def billing_country
    object.addresses.billing.first.country
  end

  def billing_phone
    object.addresses.billing.first.phone
  end

  def safe_card_number
    '*' * CARD_SYMBOLS[:count_stars] + object.card&.card_number.last(CARD_SYMBOLS[:count_card_symbols])
  end

  def number
    'R#' + object.id.to_s
  end

  def date
    object.updated_at.strftime('%B %d, %Y')
  end
end
