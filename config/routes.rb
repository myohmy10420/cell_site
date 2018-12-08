Rails.application.routes.draw do
  devise_for :users

  get "admin", to: "admin/products#index"
  namespace :admin do
    resources :products
    resources :brands
    resources :telecommunications
    resources :variants
    resources :recoveries
  end

  resources :products, only: [:index, :show]
  resources :variants, only: [:index]

  root "pages#welcome"
end
