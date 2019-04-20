ActiveAdmin.register Delivery do
  permit_params :method, :days, :price

  index do
    selectable_column
    id_column
    column :deliveryable_id
    column :method
    column :days
    column :price do |product|
      number_to_currency product.price, unit: '€'
    end
    actions
  end

  filter :method
  filter :days
  filter :price

  form do |f|
    f.inputs do
      f.input :method
      f.input :days
      f.input :price
    end
    f.actions
  end
end
