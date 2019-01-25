class CartPresenter < BasePresenter
  presents :cart

  def total_price
    cart.total_price - Cupon.find(cart.cupon_id).price
  end
end