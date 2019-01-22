class Bestsellers
  def self.call
    Product.joins('INNER JOIN products ON products.id = O.product_id')
           .from(LineItem.select('product_id, COUNT(product_id) as count')
           .group('product_id').order('count DESC').limit(4), :O)
  end
end
