Rails.application.routes.draw do
  devise_for :users

  get "admin", to: "admin/products#index"
  namespace :admin do
    resources :carousel_ads, only: [:index, :create, :destroy]
    resources :products
    post "search_products", to: "products#search"
    resources :product_images, only: [:destroy]
    resources :brands
    post "search_brands", to: "brands#search"
    resources :telecommunications
    post "search_telecommunications", to: "telecommunications#search"
    resources :variants
    post "search_variants", to: "variants#search"
    resources :recoveries
    post "search_recoveries", to: "recoveries#search"
    resources :side_bar_ads, only: [:index, :create, :destroy]
    resources :stores
    post "search_stores", to: "stores#search"
    resources :users
    post "search_users", to: "users#search"
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

  namespace :api do
    namespace :v1 do
      post "product/switch-shelved" => "products#switch_shelved"

      namespace :excel do
        get "brands/export" => "brands#export"
        post "brands/import" => "brands#import"
        get "products/export" => "products#export"
        post "products/import" => "products#import"
        get "stores/export" => "stores#export"
        post "stores/import" => "stores#import"
        get "telecommunications/export" => "telecommunications#export"
        post "telecommunications/import" => "telecommunications#import"
      end
    end
  end

  root "pages#home"
end
