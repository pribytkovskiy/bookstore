class Cover < ApplicationRecord
  belongs_to :product

  mount_uploader :image_url, FileUploader
end
