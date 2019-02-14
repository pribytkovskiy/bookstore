require 'rails_helper'

describe Order, type: :model do

  context 'associations' do
    it { expect belong_to(:user) }
    it { expect belong_to :delivery }
    it { expect belong_to :coupon }
    it { expect belong_to :card }
    it { expect have_many :order_items }
    it { expect have_many :addresses }
  end

  context 'aasm state' do
    it "default status is cart" do
      expect(subject).to have_state(:cart)
    end

    it 'add_address' do
      expect(subject).to transition_from(:cart, :confirmation).to(:address)
        .on_event(:add_address)
    end

    it 'add_delivery_method' do
      expect(subject).to transition_from(:address, :confirmation).to(:delivery_method)
        .on_event(:add_delivery_method)
    end

    it 'add_payment' do
      expect(subject).to transition_from(:delivery_method, :confirmation).to(:payment)
        .on_event(:add_payment)
    end

    it 'add_confirmation' do
      expect(subject).to transition_from(:payment).to(:confirmation)
        .on_event(:add_confirmation)
    end

    it 'add_in_queued' do
      expect(subject).to transition_from(:confirmation).to(:in_queued)
        .on_event(:add_in_queued)
    end

    it 'in_delivery' do
      expect(subject).to transition_from(:in_queued).to(:in_delivering)
        .on_event(:in_delivery)
    end

    it 'end_delivery' do
      expect(subject).to transition_from(:in_delivering).to(:delivering)
        .on_event(:end_delivery)
    end

    it 'cancel' do
      expect(subject).to transition_from(:in_queued, :in_delivering, :delivering).to(:canceling)
        .on_event(:cancel)
    end
  end

  context 'total_price' do
    subject { create(:order, :with_items) }

    it '#total_price' do
      expect(subject.total_price).to eq(
        subject.order_items.first.product.price*subject.order_items.first.quantity +
        subject.order_items.second.product.price*subject.order_items.second.quantity
      )
    end
  end
end
