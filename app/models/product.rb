class Product < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :author_products
  has_many :authors, through: :author_products
  has_many :covers, dependent: :destroy
  belongs_to :category

  accepts_nested_attributes_for :covers, allow_destroy: true

  scope :latest_products, ->(latest_default_quantity) { Product.last(latest_default_quantity) }
  scope :sort_column, ->(context) {
    Product.column_names.include?(context.params[:sort]) ? context.params[:sort] : 'created_at'
  }
  scope :sort_direction, ->(context) {
    %w[asc desc].include?(context.params[:direction]) ?  context.params[:direction] : 'desc'
  }
  scope :sort_product, ->(context) {
    order(sort_column(context) + ' ' + sort_direction(context)).where(category_id: context.category_id)
  }
end
