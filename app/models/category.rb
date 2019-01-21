class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :category, presence: true, uniqueness: true
end
