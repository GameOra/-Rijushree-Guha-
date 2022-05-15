
Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root to: 'products#index'

  resources :products

  resources :items do
    patch :deduct, on: :member
    get :subtract, on: :member
  end

  namespace :admin do
    resources :items, only: :index
    resources :users
  end
end