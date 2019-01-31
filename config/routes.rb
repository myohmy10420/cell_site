Rails.application.routes.draw do
  devise_for :users

  get "admin", to: "admin/products#index"
  namespace :admin do
    resources :products
    post "search_products", to: "products#search"
    resources :brands
    resources :telecommunications
    resources :variants
    resources :recoveries
    resources :stores
    resources :users
  end

  resources :products, only: [:index, :show] do
    collection do
      post "search"
    end
    patch "tele_search_varirnt", to: "products#search_varirnt"
  end

  resources :variants, only: [:index]
  resources :recoveries, only: [:index]
  resources :stores, only: [:index]

  root "pages#home"
end
