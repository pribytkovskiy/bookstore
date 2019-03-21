class Product < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :author_products
  has_many :authors, through: :author_products
  has_many :covers, dependent: :destroy
  belongs_to :category

  scope :latest_products, lambda(latest_default_quantity) { Product.last(latest_default_quantity) }
  scope :sort_column, lambda(context) {
    Product.column_names.include?(context.params[:sort]) ? context.params[:sort] : 'created_at'
  }
  scope :sort_direction, lambda(context) {
    %w[asc desc].include?(context.params[:direction]) ?  context.params[:direction] : 'desc'
  }
  scope :sort_product, lambda(context) {
    order(sort_column(context) + ' ' + sort_direction(context)).where(category_id: context.category_id)
  }
end
