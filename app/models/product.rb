class Product < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :author_products
  has_many :authors, through: :author_products
  has_many :covers, dependent: :destroy
  belongs_to :category

  scope :latest_products, ->(latest_default_quantity) { Product.last(latest_default_quantity) }
  scope :sort_column, ->(params) { Product.column_names.include?(params[:sort]) ? params[:sort] : 'created_at' }
  scope :sort_direction, ->(params) { %w(asc desc).include?(params[:direction]) ?  params[:direction] : 'desc' }
  scope :sort_product, ->(params, session) { order(sort_column(params) + ' ' + sort_direction(params)).where(category_id: session[:category]) }
end
