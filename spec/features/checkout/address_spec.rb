require 'rails_helper'

feature 'address step' do
  let(:user) { create(:user, :with_orders_address) }
  let(:order) { user.orders.first }

  before do 
    sign_in user
  end

  context 'when orders exist' do
    let(:bad_first_name) { FFaker.numerify('###') }
    let(:bad_city) { FFaker.numerify('###') }
    let(:bad_zip) { FFaker::Lorem.word}
    let(:bad_phone) { FFaker.numerify('############') }
    let(:last_name) { FFaker.numerify('############') }

    before do
      page.set_rack_session(order_id: order.id)
      visit order_path(id: order.id)
    end

    it 'have all fields' do
      expect(page).to have_field(I18n.t('orders.form.first_name'))
      expect(page).to have_field(I18n.t('orders.form.last_name'))
      expect(page).to have_field(I18n.t('orders.form.address'))
      expect(page).to have_field(I18n.t('orders.form.city'))
      expect(page).to have_field(I18n.t('orders.form.zip'))
      expect(page).to have_field(I18n.t('orders.form.country'))
      expect(page).to have_field(I18n.t('orders.form.phone'))
    end

    it 'show mistakes' do
      within 'div.billing_address' do
        fill_in I18n.t('orders.form.first_name'), with: bad_first_name
        fill_in I18n.t('orders.form.city'), with: bad_city
        fill_in I18n.t('orders.form.zip'), with: bad_zip
        fill_in I18n.t('orders.form.phone'), with: bad_phone
      end
      click_button(I18n.t('orders.form.save_and_continue'))

      expect(page).to have_content(I18n.t('cant_be_blank'))
      expect(page).to have_content(I18n.t('starts_with_plus'))
      expect(page).to have_content(I18n.t('only_letters'))
      expect(page).to have_css('div.has-error')
    end

    it 'saves previos values' do
      within 'div.billing_address' do
        fill_in I18n.t('orders.form.last_name'), with: last_name
      end
      click_button(I18n.t('orders.form.save_and_continue'))

      expect(page).to have_field(I18n.t('orders.form.last_name'), with: last_name)
      expect(page).to have_css('div.has-error')
    end

   it 'click use billing' do
      first('.checkbox-icon').click
      expect(page).to have_selector('.shipping_address', visible: false)

      click_button(I18n.t('orders.form.save_and_continue'))
      expect(page).to have_selector('.shipping_address', visible: false)
    end
  end
end
