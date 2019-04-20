require 'rails_helper'

describe 'confirm step' do # rubocop:disable RSpec/DescribeClass
  let(:user) { create(:user, :for_checkout_page) }
  let(:order) { user.orders.first }
  let(:shipping_address) { order.addresses.shipping.first }
  let(:billing_address) { order.addresses.billing.first }

  before do
    sign_in user
    page.set_rack_session(order_id: order.id)
    visit checkout_path(id: order.id, step: :payment, next_render: :confirmation)
  end

  it 'show order info' do # rubocop:disable RSpec/MultipleExpectations, RSpec/ExampleLength
    expect(page).to have_content(shipping_address.first_name)
    expect(page).to have_content(shipping_address.address)
    expect(page).to have_content(shipping_address.city)
    expect(page).to have_content(shipping_address.phone)
    expect(page).to have_content(shipping_address.country)

    expect(page).to have_content(billing_address.first_name)
    expect(page).to have_content(billing_address.address)
    expect(page).to have_content(billing_address.city)
    expect(page).to have_content(billing_address.phone)
    expect(page).to have_content(billing_address.country)

    expect(page).to have_content(order.delivery.method)

    expect(page).to have_content(order.card.mm_yy)
    expect(page).to have_content('****' * 3 + order.card.card_number[-4..-1])

    expect(page).to have_content(order.total_price)
  end

  it 'can edit' do
    click_link('edit', match: :first)
    expect(page).to have_current_path(checkout_path(id: order.id,
                                                    locale: 'en',
                                                    next_render: :address,
                                                    step: :address,
                                                    user_id: user.id))
  end
end
