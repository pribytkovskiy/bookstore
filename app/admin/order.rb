ActiveAdmin.register Order do
  permit_params :active_admin_requested_event, :id, :state

  index do
    column :id
    column :card_id
    tag_column :state
    column :subtotal do |product|
      number_to_currency product.subtotal, unit: I18n.t('active_admin.euro')
    end
    actions
  end

  after_save do |order|
    event = params[:order][:active_admin_requested_event]
    unless event.blank?
      safe_event = (order.aasm.events(permitted: true).map(&:name) & [event.to_sym]).first
      raise I18n.t('active_admin.forbidden_event', event: event, order: order) unless safe_event
      order.send("#{safe_event}!")
    end
  end

  form do |f|
    f.input :state, input_html: { disabled: true }, label: I18n.t('active_admin.сurrent_state')
    f.input :active_admin_requested_event, label: I18n.t('active_admin.сhange_state'), as: :select, collection: f.object.aasm.events(permitted: true).map(&:name)
    f.actions
  end
end
