ActiveAdmin.register Order do
  permit_params :active_admin_requested_event, :state

  index do
    column :id
    column :card_id
    column('State', sortable: :state) { |order| status_tag(order.state) }
    column :subtotal do |product|
      number_to_currency product.subtotal, unit: '€'
    end
    actions defaults: true do |order|
      link_to('delivery', admin_order_path(order, params.permit(:state).merge(state: :in_delivering)), html_options = { 'data-method' => 'put' }) +
      ' ' +
      link_to('end delivery', admin_order_path(order, params.permit(:state).merge(state: :delivering)), html_options = { 'data-method' => 'put' }) +
      ' ' +
      link_to('cancel', admin_order_path(order, params.permit(:state).merge(state: :canceling)), html_options = { 'data-method' => 'put' })
    end
  end

  after_save do |order|
    event = params[:order][:active_admin_requested_event]
    unless event.blank?
      safe_event = (order.aasm.events(permitted: true).map(&:name) & [event.to_sym]).first
      raise "Forbidden event #{event} requested on instance #{your_model.id}" unless safe_event
      order.send("#{safe_event}!")
    end
  end

  form do |f|
    f.input :state, input_html: { disabled: true }, label: 'Current state'
  #  f.input :active_admin_requested_event, label: 'Change state', as: :select, collection: f.object.aasm.events(permitted: true).map(&:name)
    f.actions
  end
end
