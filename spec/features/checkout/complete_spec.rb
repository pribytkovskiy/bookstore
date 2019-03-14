require 'rails_helper'

RSpec.describe 'checkout order complete' do
  let(:user) { create(:user, :for_checkout_page) }
  let(:order) { user.orders.first }
  let(:shipping_address) { order.addresses.shipping.first }
  let(:billing_address) { order.addresses.billing.first }

  before do
    order.state = :complete
    order.save
    sign_in user
    page.set_rack_session(order_id: order.id)
    visit checkout_path(id: order.id)
  end

  it 'show complete order info' do
    expect(page).to have_content(I18n.t('orders.complete.thank'))

    expect(page).to have_content(shipping_address.first_name)
    expect(page).to have_content(shipping_address.address)
    expect(page).to have_content(shipping_address.city)
    expect(page).to have_content(shipping_address.phone)
    expect(page).to have_content(shipping_address.country)

    expect(page).to have_content(order.updated_at.strftime('%B %d, %Y'))
    expect(page).to have_content("R##{order.id}")
  end

  it 'redirect to store' do
    click_button(I18n.t('orders.complete.back_to_store'))
    expect(current_path).to eq(store_path(locale: :en))
  end
end
