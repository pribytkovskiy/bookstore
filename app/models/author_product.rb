class AuthorProduct < ApplicationRecord
  belongs_to :author
  belongs_to :product

  self.primary_key = 'author_id'
end
