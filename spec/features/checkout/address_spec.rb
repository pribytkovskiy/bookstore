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

   it 'click use billing' do
      first('.checkbox-icon').click
      expect(page).to have_selector('.shipping_address', visible: false)

      click_button(I18n.t('orders.form.save_and_continue'))
      expect(page).to have_selector('.shipping_address', visible: false)
    end
  end
end
