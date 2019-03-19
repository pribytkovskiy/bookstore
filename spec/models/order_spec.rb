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

    it 'add_complete' do
      expect(subject).to transition_from(:cart).to(:complete)
        .on_event(:add_complete)
    end

    it 'add_in_queued' do
      expect(subject).to transition_from(:complete).to(:in_queued)
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

  context 'scope active_order sort_order' do
    let!(:user) { create(:user, :with_orders) }

    it 'active_order' do
      expect { Order.active_order(1)}.to raise_exception(ActiveRecord::RecordNotFound)
    end

    it 'sort_order view only completed orders and desc' do
      user.orders.third.state = :cart
      user.orders.third.save
      expect(Order.sort_order(user.id)).to eq(user.orders[0..-2].reverse)
    end

    it 'sort_order view in_queued orders' do
      user.orders.third.state = :in_queued
      user.orders.third.save
      expect(Order.sort_order(user.id, :in_queued).first).to eq(user.orders.third)
    end
  end
end
