require_dependency 'app/queries/bestsellers.rb'
class HomeController < ApplicationController
  def show
    @slide = Product.slide
    @product = BestSellers.call
  end
end
