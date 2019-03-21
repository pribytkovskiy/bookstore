require 'rails_helper'

describe 'catalog' do # rubocop:disable RSpec/DescribeClass
  let!(:products) { create_list(:product, 2) }
  let!(:params) { { category_id: 1, name_sort: I18n.t('pages.catalog.popular_first') } }

  context 'when products show or products ordering' do
    before do
      visit catalog_path(params, locale: 'en')
      within('ul.categories-list') do
        click_link products.second.category.category
      end
    end

    it 'product watching' do
      expect(page).to have_selector('.thumb-hover-link', visible: true)
      first('.thumb-hover-link').click
      expect(find('.mt-res-0')).to have_content(products.second.title)
    end

    it 'product add to cart' do
      expect(page).to have_selector('.thumb-hover-link > .fa-shopping-cart', visible: true)
      first('.thumb-hover-link > .fa-shopping-cart').click
      expect(all('.shop-icon').last).to have_content('0')
    end
  end

  context 'when change sort category' do
    before { visit catalog_path(params, locale: 'en') }

    it 'change category' do
      within('ul.categories-list') do
        click_link products.second.category.category
      end
      expect(find('.general-title')).to have_content(products.second.title)
    end

    it 'change sort' do
      click_link('Newest first', match: :first)
      expect(find('a.width-240')).to have_content(I18n.t('pages.catalog.newest_first'))
    end
  end

  context 'when right categories with quantity' do
    before { visit catalog_path(params, locale: 'en') }

    it 'when have categories name' do
      expect(page).to have_selector('.filter-link', text: I18n.t('pages.catalog.all'))
      expect(page).to have_selector('.filter-link', text: products.first.category.category)
      expect(page).to have_selector('.filter-link', text: products.second.category.category)
    end

    it 'when have right quantity nearly category' do
      expect(page).to have_selector('.general-badge', text: 1)
    end
  end
end
