ActiveAdmin.register Order do # rubocop:disable Metrics/BlockLength
  permit_params :active_admin_requested_event, :id, :state, :order, :order_id

  actions :all, except: %i[edit]

  index do
    column :id
    column :card_id
    column :state, sortable: :state do |order|
      column_select(order, :state, order.aasm.states(permitted: true).map(&:name) << order.state.to_sym)
    end
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
    order = Order.find_by(id: params[:id])
    f.input :order_id, input_html: { disabled: true, value: order.id }
    f.input :state, input_html: { disabled: true, value: order.state }, label: I18n.t('active_admin.сurrent_state')
    f.input :active_admin_requested_event,
            label: I18n.t('active_admin.сhange_state'),
            as: :select,
            collection: order.aasm.events(permitted: true).map(&:name)
    f.actions
  end
end
