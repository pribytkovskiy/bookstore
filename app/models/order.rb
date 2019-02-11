class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  belongs_to :coupon, optional: true
  belongs_to :card, optional: true
  has_many :addresses, as: :addressable
  has_many :order_items

  include AASM

  aasm column: 'state' do
    state :cart, initial: true
    state :address
    state :delivery_method
    state :payment
    state :confirmation
    state :in_queued
    state :in_delivering
    state :delivering
    state :canceling

    event :add_address do
      transitions from: :cart, to: :address
    end

    event :add_delivery_method do
      transitions from: :address, to: :delivery_method
    end

    event :add_payment do
      transitions from: :delivery_method, to: :payment
    end

    event :add_confirmation do
      transitions from: :payment, to: :confirmation
    end

    event :add_in_queued do
      transitions from: :confirmation, to: :in_queued
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
