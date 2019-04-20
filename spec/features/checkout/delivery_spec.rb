require 'rails_helper'

describe 'delivery step' do # rubocop:disable RSpec/DescribeClass
  let(:user) { create(:user, :with_orders_address) }
  let(:order) { user.orders.first }
  let!(:delivery) { create(:delivery) } # rubocop:disable RSpec/LetSetup

  before do
    sign_in create(:user)
    order.state = :delivery_method
    order.save
    page.set_rack_session(order_id: order.id)
    visit checkout_path(id: order.id, step: :address, next_render: :delivery)
  end

  it 'show delivery info' do
    expect(page).to have_content(I18n.t('checkout.address_form.regular_delivery'))
  end
end
