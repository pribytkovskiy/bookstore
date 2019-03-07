ActiveAdmin.register Cover do
  permit_params :product_id, :image_url

  filter :product

  form partial: 'form'
end
