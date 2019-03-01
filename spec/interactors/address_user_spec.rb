require 'spec_helper'

RSpec.describe AddressUser, type: :interactor do
  let(:user) { create(:user) }
  let(:address_form) { AddressForm.new }

  describe '.call' do
    context 'when given valid credentials' do
      subject(:context) { AddressUser.call(user_id: user.id) }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'user address exist' do
        expect(context.address).to be_truthy 
      end
    end
  end
end
