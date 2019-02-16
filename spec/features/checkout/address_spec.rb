require 'rails_helper'

feature 'address step' do
  before { sign_in create(:user) }

  context 'when orders exist' do
    let!(:order) { create(:order, :with_items) }
    let(:last_name) { FFaker::Name.last_name }

    before { visit order_path(id: order.id) }

    it 'have all fields' do
      expect(page).to have_field(I18n.t('orders.form.first_name'))
      expect(page).to have_field(I18n.t('orders.form.last_name'))
      expect(page).to have_field(I18n.t('orders.form.address'))
      expect(page).to have_field(I18n.t('orders.form.city'))
      expect(page).to have_field(I18n.t('orders.form.zip'))
      expect(page).to have_field(I18n.t('orders.form.country'))
      expect(page).to have_field(I18n.t('orders.form.phone'))
    end

    xit 'show mistakes' do
      within 'div.billing_address' do
        fill_in I18n.t('orders.form.first_name'), with: FFaker.numerify('###')
        fill_in I18n.t('orders.form.city'), with: FFaker.numerify('###')
        fill_in I18n.t('orders.form.zip'), with: FFaker::Lorem.word
        fill_in I18n.t('orders.form.phone'), with: FFaker.numerify('############')
      end
      click_button(I18n.t('orders.form.save_and_continue'))

      expect(page).to have_content(I18n.t('cant_be_blank'))
      expect(page).to have_content(I18n.t('starts_with_plus'))
      expect(page).to have_content(I18n.t('only_numbers'))
      expect(page).to have_content(I18n.t('only_letters'))
      expect(page).to have_css('div.has-error')
    end

    xit 'saves previos values' do
      within 'div.billing_address' do
        fill_in I18n.t('orders.form.last_name'), with: last_name
      end
      click_button(I18n.t('orders.form.save_and_continue'))

      expect(page).to have_field(I18n.t('orders.form.last_name'), with: last_name)
      expect(page).to have_css('div.has-error')
    end

   xit 'click use billing' do
      first('.checkbox-icon').click
      expect(page).to have_selector('.shipping_address', visible: false)

      click_button(I18n.t('orders.form.save_and_continue'))
      expect(page).to have_selector('.shipping_address', visible: false)
    end
  end
end
