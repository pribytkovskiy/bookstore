ActiveAdmin.register Cover do
  permit_params :product_id, :image_url

  form partial: 'form'

  show do
    attributes_table do
      row :product_id
      row :image do |cover|
        image_tag(cover.image_url, width: '50')
      end
    end
  end
end