Rails.application.routes.draw do
  get 'addresses/edit'
  get 'users/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get 'mypage', to: 'users/registrations#show'
  end
  root to: "products#index"
  resources :products, only: [:new, :create, :show, :destroy] do
    resources :orders, only: [:index, :create]
  end
  resources :addresses, only: [:edit, :update]
  resources :cards, only: [:new, :create, :show, :destroy]
end

