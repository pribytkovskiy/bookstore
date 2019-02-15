require 'rails_helper'

feature 'catalog' do
  let!(:products) { create_list(:product, 2) }
  let!(:params) { params = { category_id: 1, name_sort: I18n.t('pages.catalog.popular_first') } }

  xscenario 'visibel product page', js: true do
    visit store_path
    click_link(I18n.t('pages.catalog.shop'), match: :first)
    click_link(I18n.t('pages.catalog.all'), match: :first)
    click_link(class: 'thumb-hover-link', visible: false, match: :first)
    expect(find('.mt-res-0')).to have_content(products.second.title)
  end

  scenario "change category" do
    visit catalog_path(params, locale: 'en')
    within("ul.categories-list") do
      click_link products.second.category.category
    end
    expect(find('.general-title')).to have_content(products.second.title)
  end

  scenario "change sort" do
    visit catalog_path(params, locale: 'en')
    click_link("Newest first", match: :first)
    expect(find("a.width-240")).to have_content(I18n.t('pages.catalog.newest_first'))
  end
end
