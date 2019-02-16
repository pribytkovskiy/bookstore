require 'rails_helper'

feature 'delivery step' do
  let!(:order) { create(:order, :with_items) }
  let!(:delivery) { create(:delivery) }

  before do
    sign_in create(:user)
    order.state = :delivery_method
    visit order_path(id: order.id)
  end

  it "show delivery info" do
    expect(page).to have_content(delivery.price)
    expect(page).to have_content(delivery.days)
  end

  it "save delivery" do
    find('.radio-text', match: :first).click
    click_button(I18n.t('orders.address_form.save_and_continue'))
    expect(order.reload.delivery_id).to eq(delivery.id)
  end
end
