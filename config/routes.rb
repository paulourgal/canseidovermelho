Rails.application.routes.draw do

  root :to => "home#index"

  get "sign_up" => "users#new", :as => "sign_up"
  delete "log_out" => "sessions#destroy", :as => "log_out"

  resources :users
  resources :sessions
  resources :incomings

end
