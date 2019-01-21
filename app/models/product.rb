class Product < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :line_items
  has_many :orders, through: :line_items
  has_and_belongs_to_many :authors
  belongs_to :category
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  private

  def ensure_not_referenced_by_any_line_item
    return true if line_items.empty?
    errors.add(:base, 'There are line items')
    false
  end
end
