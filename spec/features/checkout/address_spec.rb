require 'rails_helper'

describe 'address step' do # rubocop:disable RSpec/DescribeClass
  let(:user) { create(:user, :with_orders_address) }
  let(:order) { user.orders.first }

  before do
    sign_in user
  end

  context 'when orders exist' do
    let(:bad_first_name) { FFaker.numerify('###') }
    let(:bad_city) { FFaker.numerify('###') }
    let(:bad_zip) { FFaker::Lorem.word }
    let(:bad_phone) { FFaker.numerify('############') }
    let(:last_name) { FFaker.numerify('############') }

    before do
      page.set_rack_session(order_id: order.id)
      visit checkout_path(id: order.id, step: :address, next_render: :address)
    end

    it 'have all fields' do # rubocop:disable RSpec/MultipleExpectations
      expect(page).to have_field(I18n.t('checkout.form.first_name'))
      expect(page).to have_field(I18n.t('checkout.form.last_name'))
      expect(page).to have_field(I18n.t('checkout.form.address'))
      expect(page).to have_field(I18n.t('checkout.form.city'))
      expect(page).to have_field(I18n.t('checkout.form.zip'))
      expect(page).to have_field(I18n.t('checkout.form.country'))
      expect(page).to have_field(I18n.t('checkout.form.phone'))
    end

    it 'click use billing', js: true do
      first('.checkbox-input').click
      expect(page).to have_selector('#form2', visible: false)

      click_button(I18n.t('checkout.form.save_and_continue'))
      expect(page).to have_selector('#form2', visible: false)
    end
  end
end
