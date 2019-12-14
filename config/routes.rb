Rails.application.routes.draw do
  devise_for :users

  get "admin", to: "admin#index"
  namespace :admin do
    resources :carousel_ads, only: [:index, :create, :destroy]
    resources :pre_orders
    post "search_pre_orders", to: "pre_orders#search"
    resources :products
    post "add/product/images", to: "products#quick_add_images"
    post "/product_images/delete_images", to: "product_images#delete_images"
    resources :brands
    post "search_brands", to: "brands#search"
    post "add/brand/logos", to: "brands#quick_add_logos"
    post "add/brand/category", to: "brands#add_category"
    resources :categories, only: [:destroy]
    resources :telecommunications
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

  resources :categories, only: [:index, :show]

  resources :products, only: [:show] do
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
      post "product/switch-shelved", to: "products#switch_shelved"
      post "brand/up_sort", to: "brands#up_sort"
      post "brand/down_sort", to: "brands#down_sort"
      post "carousel_ad/up_sort", to: "carousel_ads#up_sort"
      post "carousel_ad/down_sort", to: "carousel_ads#down_sort"
      post "side_bar_ad/up_sort", to: "side_bar_ads#up_sort"
      post "side_bar_ad/down_sort", to: "side_bar_ads#down_sort"

      get "dashboard/visitor_count", to: "dashboards#visitor_count"

      namespace :excel do
        get "brands/export", to: "brands#export"
        post "brands/import", to: "brands#import"
        get "pre_orders/export", to: "pre_orders#export"
        get "products/export", to: "products#export"
        post "products/import", to: "products#import"
        get "recoveries/export", to: "recoveries#export"
        post "recoveries/import", to: "recoveries#import"
        get "stores/export", to: "stores#export"
        post "stores/import", to: "stores#import"
        get "telecommunications/export", to: "telecommunications#export"
        post "telecommunications/import", to: "telecommunications#import"
        get "users/export", to: "users#export"
        post "users/import", to: "users#import"
        get "variants/export", to: "variants#export"
        post "variants/import", to: "variants#import"
      end
    end
  end

  namespace :pages do
    get "web_terms"
    get "privacy_policy"
    get "disclaimer"
  end

  root "pages#home"
end
