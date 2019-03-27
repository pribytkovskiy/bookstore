ActiveAdmin.register Comment do # rubocop:disable Metrics/BlockLength
  permit_params :product_id, :created_at, :title, :approved, :rate, :body, :user_id, :active_admin_requested_event

  filter :approved, as: :select, collection: %w[unprocessed approved rejected]
  filter :created_at
  filter :product_id
  filter :rate
  filter :title
  filter :body
  filter :user_id

  actions :all, except: [:new]

  index as: ActiveAdmin::Views::IndexAsTable do
    selectable_column
    column :product_id, &:product_id
    column :created_at, sortable: :created_at, &:created_at
    column :user_id, &:user_id
    column :title, sortable: :title, &:title
    column :approved, sortable: :approved, &:approved
    column :rate, sortable: :rate, &:rate
    column :body, sortable: false do |review|
      truncate(review.body, length: 100)
    end
    actions
  end

  after_save do |comment|
    event = params[:comment][:active_admin_requested_event]
    unless event.blank?
      safe_event = (comment.aasm.events(permitted: true).map(&:name) & [event.to_sym]).first
      raise I18n.t('active_admin.forbidden_event', event: event, order: comment) unless safe_event

      comment.send("#{safe_event}!")
    end
  end

  form do |f|
    f.input :approved, input_html: { disabled: true }, label: I18n.t('active_admin.сhange_state')
    f.input :active_admin_requested_event,
            label: I18n.t('active_admin.сhange_state'),
            as: :select,
            collection: f.object.aasm.events(permitted: true).map(&:name)
    f.actions
  end
end
