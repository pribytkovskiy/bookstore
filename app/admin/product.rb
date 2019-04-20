include ActiveAdminHelpers # rubocop:disable Style/MixinUsage
ActiveAdmin.register Product do # rubocop:disable Metrics/BlockLength
  permit_params :id, :title, :category_id, :price, :description, :product, :locale,
                :year, :dimensions, :materials, covers: [], author_ids: [], covers_attributes: %i[id _destroy image_url]

  index do
    column :title
    column :authors do |product|
      product.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
    end
    column :category do |category|
      category.category.category.to_s
    end
    column :description
    column :year do |product|
      product.year.strftime('%Y')
    end
    column :dimensions
    column :materials
    column :covers do |product|
      image_tag(product.covers.first&.image_url.try(:url), width: '50') if product.covers.first
    end
    column :price do |product|
      number_to_currency product.price, unit: '€'
    end
    actions
  end

  show do
    render 'show'
  end

  form do |f|
    f.inputs :product do
      f.input :title
      f.input :authors, as: :check_boxes, collection: collected_authors(f)
      f.input :category, label: :category, as: :select, collection: category_all
      f.input :description
      f.input :year
      f.input :dimensions
      f.input :materials
      f.input :price
    end
    f.inputs :covers do
      f.has_many :covers, heading: nil, allow_destroy: true, new_record: true do |ff|
        if !ff.object.new_record?
          ff.input :image_url,
                   as: :file,
                   hint: image_tag(ff.object.image_url.try(:url), width: '50'),
                   label: ff.object.image_url.filename
        else
          ff.input :image_url, as: :file
        end
      end
    end
    f.actions
  end
end
