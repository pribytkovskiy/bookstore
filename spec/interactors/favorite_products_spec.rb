require 'spec_helper'

describe FavoriteProducts, type: :interactor do
  subject(:context) { FavoriteProducts.call }

  let(:latest_products) { Product.latest_products(context.latest_default_quantity) }
  let(:bestsellers) { Bestsellers.call(context.bestsellers_default_quantity) }

  describe '.call' do
    it 'succeeds' do
      expect(context).to be_a_success
    end

    it 'latest_products' do
      expect(context.latest_products).to eq(subject.latest_products)
    end

    it 'bestsellers' do
      expect(context.bestsellers).to eq(subject.bestsellers)
    end
  end
end
