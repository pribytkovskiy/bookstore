require 'rails_helper'

RSpec.feature 'Checkout order complete' do
  let(:user) { create(:user, :for_checkout_page) }
  let(:order) { user.orders.first }

  before do
    sign_in user
    order.state = :complete
    order.save
    page.set_rack_session(order_id: order.id)
    visit order_path(id: order.id)
  end

  it 'show complete order info' do
    expect(page).to have_content('Thank You for your Order!')
    expect(page).to have_content('An order confirmation has been sent to #{@user.email}')

    expect(page).to have_content(address.first_name + " " + address.last_name)
    expect(page).to have_content(address.address_name)
    expect(page).to have_content(address.city)
    expect(page).to have_content(address.phone)
    expect(page).to have_content(address.country)

    expect(page).to have_content(book.title)
    expect(page).to have_content("€#{book.price}")
    expect(page).to have_content(book.description.slice(0, 137))

    expect(page).to have_content(@order.created_at.strftime("%m/%d/%Y"))
    expect(page).to have_content("Order ##{@order.track_number}")
  end

  it 'redirect to catalog' do
    category = create(:category)
    click_link("Go to Shop")
    expect(current_path).to eq(category_path(category.id))
  end
end
