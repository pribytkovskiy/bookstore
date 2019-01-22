class Author < ApplicationRecord
  has_many :author_products
  has_many :products, through: :author_products

  validates :first_name, :last_name, presence: true
end
