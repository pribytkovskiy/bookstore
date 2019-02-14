require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "associations" do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:authors) }
    it { should have_many(:covers).dependent(:destroy) }
    it { expect belong_to :category }
    it { expect have_many :order_items }
    it { expect have_many(:orders).through :order_items }
    it { expect have_many :author_products }
    it { expect have_many(:authors).through :author_products }
  end

  describe 'scopes' do
    let(:context) { instance_double('Context', category_id: FFaker.numerify('#'), params: { sort: nil, direction: nil }) }
    let!(:products) { create_list(:product, 2) }

    it 'latest_products' do
      expect(Product.latest_products(1)).to eq([products.second])
    end

    it 'sort_column' do
      expect(Product.sort_column(context)).to eq('created_at')
    end

    it 'sort_direction' do
      expect(Product.sort_direction(context)).to eq('desc')
    end

    it 'sort_product' do
      expect(Product.sort_product(context).where_values_hash).to eq('category_id'=>context.category_id)
    end
  end
end
