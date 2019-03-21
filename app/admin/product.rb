ActiveAdmin.register Product do # rubocop:disable Metrics/BlockLength
  permit_params :id, :title, :category_id, :price, :description,
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
      image_tag(product.covers.first&.image_url.try(:url), width: '50')
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
          image_tag(product.covers.first.image_url.try(:url), width: '50')
        end
      end
    end
  end

  form partial: 'form'

  controller do
    def update
      meaning(params)
      if @product.save && @cover.save
        render :index
      else
        render :edit
      end
    end

    private

    def meaning(params)
      @cover = Cover.find_by(id: params[:cover][:id])
      @cover.image_url = params[:cover][:cover_product]
      @product = Product.update(permitted_params[:id], permitted_params[:product])
    end
  end
end
