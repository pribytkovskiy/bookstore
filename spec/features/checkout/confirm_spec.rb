require 'rails_helper'

feature 'confirm step' do
  let(:user) { create(:user, :for_checkout_page) }
  let(:order) { user.orders.first }

  before do
    sign_in user
    page.set_rack_session(order_id: order.id)
    visit order_path(id: order.id)
  end

  xit 'show order info' do
    expect(page).to have_content(address.first_name)
    expect(page).to have_content(address.address)
    expect(page).to have_content(address.city)
    expect(page).to have_content(address.phone)
    expect(page).to have_content(address.country)

    expect(page).to have_content(delivery.method)

    expect(page).to have_content(card.mm_yy)
    expect(page).to have_content('****' * 3 + card.number[-4..-1])

    expect(page).to have_content(order.total_price)
  end

  xit 'can edit and redirect back' do
    click_link('edit', match: :first)
    expect(current_path).to eq('/checkouts/address')

    click_button(I18n.t('orders.address_form.save_and_continue'))
    expect(current_path).to eq('/checkouts/confirm')
  end
end
