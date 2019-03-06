ActiveAdmin.register Product do
  permit_params :id, :title, :category_id, :price, :description, :year, :dimensions, :materials, covers: [], author_ids: []

  index do
    column :title
    column :authors do |product|
      product.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
    end
    column :category do |category|
      "#{category.category.category}"
    end
    column :description
    column :year do |product|
      product.year.strftime("%Y")
    end
    column :dimensions
    column :materials
    column :covers, style: :thumb do |product|
      image_tag(product.covers.first.image_url, width: '50')
    end
    column :price do |product|
      number_to_currency product.price, unit: '€'
    end
    actions
  end

  form(html: { multipart: true }) do |f|
    f.inputs I18n.t('active_admin.create_product') do
      f.input :title
      collected_data = Author.all.map{|author| ["#{author.first_name} #{author.last_name}", author.id, {checked: f.object.authors.include?(author.id.to_s)}]}
      f.input :authors, as: :check_boxes, collection: collected_data
      f.input :category, :label => 'category', :as => :select, :collection => Category.all.map{|category| [category.category, category.id]}
      f.input :description
      f.input :year
      f.input :dimensions
      f.input :materials
      f.inputs :covers
      f.input :price
    end
    f.actions
  end

  controller do
    def update
      @product = Product.update(permitted_params[:id], permitted_params[:product])
      if @product.save
        render :index
      else
        render :edit
      end
    end
  end
end
