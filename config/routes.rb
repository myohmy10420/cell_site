Rails.application.routes.draw do
  devise_for :users

  get "admin", to: "admin/products#index"
  namespace :admin do
    resources :products
  end

  root "pages#welcome"
end
