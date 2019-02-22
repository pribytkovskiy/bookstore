require 'rails_helper'

feature 'payment step' do
  let!(:order) { create(:order, :with_items) }
  let!(:card) { create(:card) }

  before do
    sign_in create(:user)
    order.state = :payment
    visit order_path(id: order.id)
  end

  it 'show all fields' do
    expect(page).to have_field(I18n.t('orders.payment.card_number'))
    expect(page).to have_field(I18n.t('orders.payment.name_on_card'))
    expect(page).to have_field(I18n.t('orders.payment.mm_yy'))
    expect(page).to have_field(I18n.t('orders.payment.cvv'))
  end

  it "show mistakes" do
    fill_in I18n.t('orders.payment.card_number'), FFaker.numerify('###')
    fill_in I18n.t('orders.payment.name_on_card'), FFaker.numerify('###')
    fill_in I18n.t('orders.payment.mm_yy'), with: FFaker.numerify('###')
    fill_in I18n.t('orders.payment.cvv'), with: FFaker::Lorem.words.join
    click_button(I18n.t('orders.address_form.save_and_continue'))

    expect(page).to have_content(I18n.t('only_letters'))
    expect(page).to have_content(I18n.t('16_characters'))
    expect(page).to have_content(I18n.t('4_characters'))
    expect(page).to have_content("only allows digits")
    expect(page).to have_css('div.has-error')
  end

  it "saves previos values"do
    fill_in I18n.t('orders.payment.card_number'), with: card.number

    click_button(I18n.t('orders.address_form.save_and_continue'))

    expect(page).to have_field(I18n.t('orders.payment.card_number'), with: card.number)
    expect(page).to have_css('div.has-error')
  end

  it "saves valid data" do
    fill_in "Card Number", with: card.number
    fill_in "Name on Card", with: card.name
    fill_in "MM / YY", with: card.mm_yy
    fill_in "CVV", with: card.cvv

    expect { 
      click_button(I18n.t('orders.address_form.save_and_continue'))
    }.to change(Card, :count).by(1)
  end
end
