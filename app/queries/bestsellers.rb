class Bestsellers
  def self.call(bestsellers_default_quantity)
    Product.joins(:orders)
           .group('order_items.product_id', 'products.id')
           .order('SUM(order_items.quantity) desc')
           .limit(bestsellers_default_quantity)
  end
end
