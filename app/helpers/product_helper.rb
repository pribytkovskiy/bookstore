module ProductHelper
  def set_views(product)
    product.views += 1
    product.save
  end
end 
 