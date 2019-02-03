class Bestsellers
  def self.call(quantity_bestsellers)
    Product.joins(:orders)
           .group('order_items.product_id', 'products.id')
           .order('SUM(order_items.quantity) desc')
           .limit(quantity_bestsellers)
  end
end
