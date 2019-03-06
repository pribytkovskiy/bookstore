class Order < ApplicationRecord
  include AASM

  attr_accessor :active_admin_requested_event

  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  belongs_to :coupon, optional: true
  belongs_to :card, optional: true
  has_many :addresses, as: :addressable
  has_many :order_items

  scope :active_order, ->(order_id) { 
    where(state: %i(cart address delivery_method payment confirmation complete)).find(order_id) 
  }
  scope :sort_order, ->(user_id, sort_order = nil) {
    where(user_id: user_id)
    .where(state: sort_order || %i(in_queued in_delivering delivering canceling))
    .order(id: :desc)
  }
  
  aasm column: 'state' do
    state :cart, initial: true
    state :address
    state :delivery_method
    state :payment
    state :confirmation
    state :complete
    state :in_queued
    state :in_delivering
    state :delivering
    state :canceling

    event :add_address do
      transitions from: %i(cart confirmation), to: :address
    end

    event :add_delivery_method do
      transitions from: %i(address confirmation), to: :delivery_method
    end

    event :add_payment do
      transitions from: %i(delivery_method confirmation), to: :payment
    end

    event :add_confirmation do
      transitions from: :payment, to: :confirmation
    end

    event :add_complete do
      transitions from: :confirmation, to: :complete
    end

    event :add_in_queued do
      transitions from: :complete, to: :in_queued
    end

    event :in_delivery do
      transitions from: :in_queued, to: :in_delivering
    end

    event :end_delivery do
      transitions from: :in_delivering, to: :delivering
    end

    event :cancel do
      transitions from: %i(in_queued in_delivering delivering), to: :canceling
    end
  end

  def total_price
    order_items.sum(&:total_price)
  end
end
