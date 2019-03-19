require 'rails_helper'

describe 'payment step' do
  let(:user) { create(:user, :with_orders_address) }
  let(:order) { user.orders.first }
  let(:card) { create(:card) }
  let(:bad_card_number) { FFaker.numerify('###') }
  let(:bad_name_on_card) { FFaker.numerify('###') }
  let(:bad_mm_yy) { FFaker.numerify('###') }
  let(:bad_cvv) { FFaker::Lorem.words.join }

  before do
    sign_in user
    order.state = :payment
    order.save
    page.set_rack_session(order_id: order.id)
    visit checkout_path(id: order.id, step: :delivery_method, next_render: :payment)
  end

  it 'show all fields' do
    expect(page).to have_field(I18n.t('checkout.payment.card_number'))
    expect(page).to have_field(I18n.t('checkout.payment.name_on_card'))
    expect(page).to have_field(I18n.t('checkout.payment.mm_yy'))
    expect(page).to have_field(I18n.t('checkout.payment.cvv'))
  end

  it 'show mistakes' do
    fill_in I18n.t('checkout.payment.card_number'), with: bad_card_number
    fill_in I18n.t('checkout.payment.name_on_card'), with: bad_name_on_card
    fill_in I18n.t('checkout.payment.mm_yy'), with: bad_mm_yy
    fill_in I18n.t('checkout.payment.cvv'), with: bad_cvv
    click_button(I18n.t('checkout.address_form.save_and_continue'))

    expect(page).to have_content(I18n.t('only_letters'))
    expect(page).to have_content(I18n.t('16_characters'))
    expect(page).to have_content(I18n.t('4_characters'))
    expect(page).to have_css('div.has-error')
  end

  it 'saves previos values' do
    fill_in I18n.t('checkout.payment.card_number'), with: card.card_number

    click_button(I18n.t('checkout.address_form.save_and_continue'))

    expect(page).to have_field(I18n.t('checkout.payment.card_number'), with: card.card_number)
    expect(page).to have_css('div.has-error')
  end
end
