class Product < ApplicationRecord
  QUANTITY_PRODUCT_TO_SLIDE = 2

  has_many :comments, dependent: :destroy
  has_many :line_items
  has_many :orders, through: :line_items
  has_many :author_products
  has_many :authors, through: :author_products
  has_many :covers, dependent: :destroy
  belongs_to :category

  before_destroy :ensure_not_referenced_by_any_line_item?

  scope :slide, -> { Product.all.last(QUANTITY_PRODUCT_TO_SLIDE) }
  scope :sort_column, ->(params) { Product.column_names.include?(params[:sort]) ? params[:sort] : 'created_at' }
  scope :sort_direction, ->(params) { %w(asc desc).include?(params[:direction]) ?  params[:direction] : 'desc' }
  scope :sort_product, ->(params, session) { order(sort_column(params) + ' ' + sort_direction(params)).where(category_id: session[:category]) }

  private

  def ensure_not_referenced_by_any_line_item?
    return true if line_items.empty?

    errors.add(:base, 'There are line items')
    false
  end
end
