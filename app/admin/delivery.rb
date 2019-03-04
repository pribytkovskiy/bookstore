ActiveAdmin.register Delivery do
  permit_params :method, :days, :price

  index do
    column :method
    column :days
    column :price do |product|
      number_to_currency product.price, unit: '€'
    end
    actions
  end
end