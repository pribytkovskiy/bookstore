class Comment < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :product

  aasm column: 'approved', whiny_transitions: false do
    state :unprocessed, initial: true
    state :approved, :rejected

    event :approve do
      transitions from: :unprocessed, to: :approved
    end

    event :reject do
      transitions from: :unprocessed, to: :rejected
    end

    event :unprocess do
      transitions from: %i(rejected approved), to: :unprocessed
    end
  end

  validates :rate, :title, :body, presence: true
  validates_inclusion_of :rate, in: 1..5

  validates :title, length: { maximum: 80 }
  validates :body, length: { maximum: 500 }
end
