Rails.application.routes.draw do
  devise_for :users

  get "admin", to: "admin/products#index"
  namespace :admin do
    resources :products
    resources :brands
    resources :telecommunications
    resources :variants
  end

  resources :products

  root "pages#welcome"
end
