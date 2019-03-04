ActiveAdmin.register Coupon do
  permit_params :number, :price

  index do
    column :number
    column :price do |product|
      number_to_currency product.price, unit: '€'
    end
    actions
  end
end