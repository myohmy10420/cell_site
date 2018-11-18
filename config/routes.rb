Rails.application.routes.draw do
  devise_for :users

  get "admin", to: "admin#index"

  root "pages#welcome"
end
