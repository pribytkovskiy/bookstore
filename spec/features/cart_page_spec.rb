require 'rails_helper'

describe 'cart' do # rubocop:disable RSpec/DescribeClass
  it 'when no current order redirect to home' do
    visit cart_path(id: 1)
    expect(page).to have_current_path('/en')
  end

  context 'when user have current order' do
    let(:user) { create(:user, :with_orders_address) }
    let!(:product) { create(:product) } # rubocop:disable RSpec/LetSetup
    let(:coupon) { create(:coupon) }

    before do
      sign_in user
      visit store_path
      click_button(I18n.t('pages.home.buy_now'))
      visit cart_path(id: 1)
    end

    it 'show order info' do
      expect(page).to have_content(Order.last.total_price)
      expect(page).to have_field(I18n.t('carts.show.enter_your_coupon_code'))
    end

    it 'can delete order item' do
      expect { find('.general-cart-close', match: :first).click }.to change(OrderItem, :count).by(-1)
    end

    it 'change quantity in order item', js: true do
      find('.fa-plus', match: :first).click
      expect(OrderItem.last.quantity).to eq(2)
      find('.fa-minus', match: :first).click
      expect(OrderItem.last.quantity).to eq(1)
    end

    it 'activate coupon' do
      fill_in 'order[number]', with: coupon.number
      click_button(I18n.t('carts.show.update_cart'))
      expect(page).to have_content(coupon.price)
    end

    it 'wrong coupon code' do
      fill_in 'order[number]', with: coupon.price
      click_button(I18n.t('carts.show.update_cart'))
      expect(page).not_to have_content(coupon.price)
    end
  end
end
