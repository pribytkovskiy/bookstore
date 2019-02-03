class PagesController < ApplicationController
  before_action :set_labels

  QUANTITY_BESTSELLERS = 4
  LATEST_DEFAULT_QUANTITY = 2

  def home
    @favorites = FavoriteProducts.call(
      latest_default_quantity: LATEST_DEFAULT_QUANTITY, quantity_bestsellers: QUANTITY_BESTSELLERS
    )
  end

  def catalog

  end

  def cart

  end

  private

  def set_labels
    @labels = Category.all
  end
end
