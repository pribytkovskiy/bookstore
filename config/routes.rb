Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope '(:locale)' do
    resources :settings, only: %i[index create update destroy]
    resource :settings, only: [:edit] do
      collection do
        patch 'update_password'
      end
    end
    resources :orders, only: %i[index show edit update]
    resources :order_items, only: %i[create update destroy]
    resources :carts, only: %i[show update]
    resource :product, only: %i[show] do
    resources :comments, only: %i[index create]
    end

    root 'pages#home', as: 'store', via: :all

    get '/', to: 'pages#home', as: 'home'
    get '/catalog', to: 'pages#catalog', as: 'catalog'
  end
end
