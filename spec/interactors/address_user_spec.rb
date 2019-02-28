require 'spec_helper'

RSpec.describe AddressUser, type: :interactor do
  let(:user) { create(:user) }
  let(:address_form) { instance_double('AddressForm') }

  before do
    allow(address_form).to receive(:permit!).and_return(true)
  end

  describe '.call' do
    context 'when given valid credentials' do
      subject(:context) { AddressUser.call(user_id: user.id) }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'user address exist' do
        expect(context.address).to exist 
      end
    end

    context 'when given invalid credentials' do
      subject(:context) { AddressUser.call(user_id: user.id, address_form: address_form) }

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides a failure message' do
        expect(context.message).to be_present
      end
    end
  end
end
