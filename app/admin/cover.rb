ActiveAdmin.register Cover do
  permit_params :product_id, :image_url, covers: []

  form partial: 'form'

  show do
    attributes_table do
      row :product_id
      row :image_url do |cover|
        image_tag url_for(cover.image_url)
      end
    end
  end
end