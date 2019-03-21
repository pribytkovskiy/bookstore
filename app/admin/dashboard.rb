ActiveAdmin.register_page 'Dashboard' do # rubocop:disable Metrics/BlockLength
  menu priority: 1
  content title: proc { I18n.t('active_admin.dashboard') } do # rubocop:disable Metrics/BlockLength
    columns do
      column do
        panel I18n.t('active_admin.recent_orders') do
          table_for Order.last(10) do
            column(I18n.t('active_admin.state')) { |order| status_tag(order.state) }
            column(I18n.t('active_admin.customer'), &:user_id)
            column(I18n.t('active_admin.total')) { |order| number_to_currency order.subtotal, unit: '€' }
          end
        end
      end

      column do
        panel 'Recent Customers' do
          table_for User.order('id desc').limit(10).each do |_customer|
            column(I18n.t('active_admin.email'), &:email)
            column(I18n.t('active_admin.id'), &:id)
          end
        end
      end
    end

    columns do
      column do
        div do
          br
          # rubocop:disable Metrics/LineLength
          text_node %(<iframe src="https://rpm.newrelic.com/public/charts/6VooNO2hKWB" width="500" height="300" scrolling="no" frameborder="no"></iframe>).html_safe
          # rubocop:enable Metrics/LineLength
        end
      end
    end
  end
end
