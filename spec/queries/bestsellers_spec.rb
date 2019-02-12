require 'rails_helper'

RSpec.describe Bestsellers do
  
  context 'returns 4 books' do
    it 'sorts' do
      expect(described_class.call).to eq([])
    end
  end
end

describe PostService do
  let(:number_of_comments) { 30 }
  let!(:comments) { create_list(:comment, number_of_comments) }

  context 'method with N+1 problem' do
    it 'should have 4 queries' do
      expect { PostService.new.last_posts_wrong(10) }.to query_limit_eq(4)
    end

    it 'should have 4 queries' do
      expect { PostService.new.last_posts_wrong(20) }.to query_limit_eq(4)
    end
  end
end