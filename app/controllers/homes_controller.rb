require_dependency './app/queries/bestsellers.rb'
class HomesController < ApplicationController
  def show
    @slide = Product.slide
    @bestsellers = Bestsellers.call
  end
end
