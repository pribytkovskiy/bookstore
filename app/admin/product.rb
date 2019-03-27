ActiveAdmin.register Product do # rubocop:disable Metrics/BlockLength
  include ActiveAdminHelpers
  permit_params :id, :title, :category_id, :price, :description, :product, :locale,
                :year, :dimensions, :materials, covers: [], author_ids: []

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
    attributes_table do
      default_attribute_table_rows.each do |field|
        row field
      end

      attributes_table_for product do
        row :covers do
          image_tag(product.covers.first.image_url.try(:url), width: '50') if product.covers.first
        end
      end
    end
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
        ff.input :image_url
      end
    end
    f.actions
  end

  controller do
    def update
      if update_product(params) && update_cover(params)
        render :index
      else
        render :edit
      end
    end

    private

    def update_product(_params)
      product = Product.find_by(id: permitted_params[:id])
      product.update(permitted_params[:product])
    end

    def update_cover(params)
      @covers = params[:product][:covers_attributes].to_unsafe_h.map do |_k, v|
        cover = Cover.find_by(id: v[:id])
        upload = Cloudinary::Uploader.upload(v[:image_url].tempfile) if v[:image_url]
        cover.update(image_url: upload) if v[:image_url]
      end
    end
  end
end
