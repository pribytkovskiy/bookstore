require 'rails_helper'

feature 'product page' do
  let(:order) { create(:order, :with_items) }
  let(:product) { order.order_items.first.product.decorate }

  before do
    sign_in create(:user)
    visit product_path(locale: 'en', id: product.id)
  end

  context 'product content' do
    let(:product_quantity) { 2 }

    scenario 'present title' do
      expect(page).to have_content(product.title)
    end

    scenario 'present authors' do
      expect(page).to have_content(product.author_name)
    end

    scenario 'present price' do
      expect(page).to have_content(product.price)
    end

    scenario 'present date' do
      expect(page).to have_content(product.date)
    end

    scenario 'present materials' do
      expect(page).to have_content(product.materials)
    end

    scenario 'present dimensions' do
      expect(page).to have_content(product.dimensions)
    end

    scenario 'add product to cart change quantity' do
      fill_in 'quantity', with: product_quantity
      click_button(I18n.t('products.show.add_to_cart'), match: :first)
      expect(order.order_items.first.quantity).to eq(order.order_items.first.quantity)
    end

    scenario 'back link' do
      visit home_path
      expect(page).to have_selector('.thumb-hover-link > .fa-shopping-cart', visible: true)
      first('.thumb-hover-link > .fa-shopping-cart').click
      expect(page).to have_current_path(home_path)
    end
  end

  context 'reviews content' do
    let(:comment) { create(:comment) }

    scenario 'must present count of reviews' do
      expect(page).to have_content(product.comments.approved.count.to_s)
    end
  
    scenario 'create new review' do
      fill_in 'comment[rate]', with: comment.rate
      fill_in 'comment[title]', with: comment.title
      fill_in 'comment[body]', with: comment.body
      expect { click_button I18n.t('products.form_review.post') }.to change{ product.comments.count }.by(1)
    end
  end
end
