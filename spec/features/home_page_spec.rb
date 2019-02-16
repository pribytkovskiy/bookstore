require 'rails_helper'

feature 'home page' do
  before { visit home_path }

  context 'when visit everyone must present elemets' do
    it 'home link must present' do
      expect(page).to have_current_path('/')
    end

    it 'must present working shop link' do
      first('a', text: I18n.t('layouts.application.shop')).click
      expect(page).to have_current_path('/en/catalog')
    end

    it 'must present working log in link' do
      first('a', text: I18n.t('layouts.application.sign_in')).click
      expect(page).to have_current_path('/users/sign_in')
    end

    it 'must present working sign up link' do
      first('a', text: I18n.t('layouts.application.sign_up')).click
      expect(page).to have_current_path('/users/sign_up')
    end
  end

  context 'when user visit must present elemets' do
    before { sign_in create(:user) }

    it 'user visit must present my account' do
      expect(page).to have_content(I18n.t('layouts.application.my_account'))
    end

    it 'user visit must present log out' do
      expect(page).to have_content(I18n.t('layouts.application.log_out'))
    end
  end

  it 'can open catalog page' do
    click_button(I18n.t('pages.home.get_started'))
    expect(page).to have_current_path('/en/catalog')
  end

  it 'create order for favorites' do
    let!(:order) { create(:order, :with_items) }

    it 'can add book to cart', js: true do
      visit home_path
      click_button(I18n.t('pages.home.buy_now'))
      expect(find('.shop-icon')).to have_content('1')
    end

    it 'must present Best Sellers' do
      visit home_path
      expect(page).to have_content order.order_items.first.product.title
    end
  end
end
