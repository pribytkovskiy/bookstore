ActiveAdmin.register Comment do # rubocop:disable Metrics/BlockLength
  permit_params :product_id, :created_at, :title, :approved, :rate, :body, :user_id

  filter :approved, as: :select, collection: %w[unprocessed approved rejected]
  filter :created_at
  filter :product_id
  filter :rate
  filter :title
  filter :body
  filter :user_id

  actions :all, except: [:edit]

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
    actions defaults: true do |review|
      # rubocop:disable Metrics/LineLength, Style/BracesAroundHashParameters
      link_to('Approve', admin_comment_path(review, params.permit(:approved).merge(approved: 'approved')), { 'data-method': 'put' }) +
        ' ' +
        link_to('Reject', admin_comment_path(review, params.permit(:approved).merge(approved: 'rejected')), { 'data-method': 'put' })
      # rubocop:enable Metrics/LineLength, Style/BracesAroundHashParameters
    end
  end

  controller do
    def update
      review = Comment.find(params[:id])
      review.update_attributes(approved: params['approved']) if params['approved'].present?
      redirect_back(fallback_location: admin_comments_path)
    end
  end
end
