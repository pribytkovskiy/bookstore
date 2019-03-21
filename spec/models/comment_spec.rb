require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    %i[user_id product_id body title rate].each do |field|
      it { validate_presence_of(field) }
    end
    it { validate_length_of(:body).is_at_most(500) }
    it { validate_length_of(:title).is_at_most(80) }
    it { validate_numericality_of(:rate).is_greater_than(1) }
    it { validate_numericality_of(:rate).is_less_than_or_equal_to(5) }
  end

  describe 'associations' do
    it { belong_to(:user) }
    it { belong_to(:book) }
  end

  describe 'statuses' do
    it 'default status is unprocessed' do
      expect(subject).to have_state(:unprocessed)
    end

    it 'after approve should have status approved' do
      subject.approve
      expect(subject).to have_state(:approved)
    end

    it 'after reject should have status rejected' do
      subject.reject
      expect(subject).to have_state(:rejected)
    end

    it 'after unprocess should have status unprocessed' do
      subject.unprocess
      expect(subject).to have_state(:unprocessed)
    end
  end
end
