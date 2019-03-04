require 'rails_helper'

describe ApplicationController, type: :controller do
  controller do
    def index
      render html: 'Hello World'
    end
  end

  describe 'before_action' do
    before { get :index }

    it 'assigns @labels' do
      expect(assigns(:labels)).not_to be_nil
    end

    it 'assigns @order' do
      expect(assigns(:order)).not_to be_nil
    end
  end
end
