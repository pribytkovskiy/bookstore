class FavoriteProducts
  include Interactor

  def call
    context.latest_products = Product.latest_products(context.latest_default_quantity)
    context.bestsellers = Bestsellers.call(context.bestsellers_default_quantity)
  end
end
