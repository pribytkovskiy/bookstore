class AuthorProduct < ApplicationRecord
  belongs_to :author
  belongs_to :product
end
