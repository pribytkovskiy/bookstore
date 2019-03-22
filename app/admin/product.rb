ActiveAdmin.register Product do # rubocop:disable Metrics/BlockLength
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
    f.inputs 'Product' do
      f.input :title
      collected_authors = Author.all.map do |author|
        ["#{author.first_name} #{author.last_name}", author.id, { checked: f.object.authors.include?(author.id.to_s) }]
      end
      f.input :authors, as: :check_boxes, collection: collected_authors
      f.input :category, label: 'category', as: :select,
        collection: Category.all.map { |category| [category.category, category.id] }
      f.input :description
      f.input :year
      f.input :dimensions
      f.input :materials
      f.input :price
    end
    f.inputs 'Covers' do
      f.has_many :covers, heading: nil, allow_destroy: true, new_record: true do |ff|
        ff.input :image_url
      end
    end
    f.actions
  end

  controller do
    def update
      meaning(params)
      if @product.save && @covers.map(&:save)
        render :index
      else
        render :edit
      end
    end

    private

    def meaning(params)
      @product = Product.update(permitted_params[:id], permitted_params[:product])
      @covers = params[:product][:covers_attributes].to_unsafe_h.map do |_k, v|
        cover = Cover.find_by(id: v[:id])
        upload = Cloudinary::Uploader.upload(v[:image_url].tempfile)
        cover.image_url = upload
        cover
      end
    end
  end
end
