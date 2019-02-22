require 'rails_helper'

feature 'delivery step' do
  let(:user) { create(:user, :with_orders_address) }
  let(:order) { user.orders.first }
  let!(:delivery) { create(:delivery) }

  before do
    sign_in create(:user)
    order.state = :delivery_method
    order.save
    page.set_rack_session(order_id: order.id)
    visit order_path(id: order.id)
  end

  it 'show delivery info' do
    expect(page).to have_content(I18n.t('orders.address_form.regular_delivery'))
  end

  it 'save delivery' do
    find('.radio-text', match: :first).click
    click_button(I18n.t('orders.address_form.save_and_continue'))
    expect(order.reload.delivery_id).to eq(delivery.id)
  end
end
