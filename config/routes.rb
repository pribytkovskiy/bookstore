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
    resource :pages, only: %i[show]
    resources :orders, only: %i[show create]
    resources :line_items, only: %i[create update destroy]
    resources :carts, only: %i[show edit update]
    resources :payment, only: %i[index create]
    resources :confirm, only: %i[index]
    resources :complete, only: %i[index]
    resources :delivery, only: %i[index create]
    resources :view_orders, only: %i[index]
    resource :product do
      resources :comments
    end

    root 'pages#show', as: 'store', via: :all
  end
end
