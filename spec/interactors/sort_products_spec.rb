require 'spec_helper'

RSpec.describe SortProducts, type: :interactor do
  let(:category) { create(:category) }
  let(:products) { create_list(:product, 3) }
  subject(:context) { SortProducts.call(params: params = { name_sort: nil }, category_id: category.id) }

  describe '.call' do
    it 'succeeds' do
      expect(context).to be_a_success
    end

    it 'sort products' do
      expect(context.products).to eq(products.reverse)
    end
  end
end
