class PagesController < ApplicationController
  def show
    
    render params[:page]&.to_sym || :home
  end
end
