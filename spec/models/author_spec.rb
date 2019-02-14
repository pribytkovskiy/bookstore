require 'rails_helper'

RSpec.describe Author, type: :model do
  let(:author) { build :author }

  describe 'validations' do
      describe 'first_name' do
        it { expect(author).to validate_presence_of(:first_name) }
      end

      describe 'last_name' do
        it { expect(author).to validate_presence_of(:last_name) }
    end

    context 'valid attributes' do
      it { expect(author).to be_valid }
    end
  end

  describe 'associations' do
    it { expect have_many :products }
    it { expect have_many(:products).through :author_products }
  end
end
