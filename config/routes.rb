Rails.application.routes.draw do
  devise_for :users

  get "admin", to: "admin/products#index"
  namespace :admin do
    resources :carousel_ads, only: [:index, :create, :destroy]
    resources :products
    post "search_products", to: "products#search"
    post "add/product/images", to: "products#quick_add_images"
    resources :product_images, only: [:destroy]
    resources :brands
    post "search_brands", to: "brands#search"
    post "add/brand/logos", to: "brands#quick_add_logos"
    resources :telecommunications
    post "search_telecommunications", to: "telecommunications#search"
    post "add/telecommunication/logos", to: "telecommunications#quick_add_logos"
    resources :variants
    post "search_variants", to: "variants#search"
    resources :recoveries
    post "search_recoveries", to: "recoveries#search"
    resources :side_bar_ads, only: [:index, :create, :destroy]
    resources :stores
    post "search_stores", to: "stores#search"
    post "add/store/images", to: "stores#quick_add_images"
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
        get "recoveries/export" => "recoveries#export"
        post "recoveries/import" => "recoveries#import"
        get "stores/export" => "stores#export"
        post "stores/import" => "stores#import"
        get "telecommunications/export" => "telecommunications#export"
        post "telecommunications/import" => "telecommunications#import"
        get "users/export" => "users#export"
        post "users/import" => "users#import"
        get "variants/export" => "variants#export"
        post "variants/import" => "variants#import"
      end
    end
  end

  root "pages#home"
end
