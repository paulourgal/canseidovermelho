Rails.application.routes.draw do

  delete "log_out" => "sessions#destroy", :as => "log_out"

  get "confirmation" => "users#confirmation", :as => "confirmation"
  get "sign_up" => "users#new", :as => "sign_up"

  resources :incomings, only: [:index, :new, :create]
  resources :outgoings, only: [:index, :new, :create]
  resources :password_resets
  resources :sessions
  resources :users

  root :to => "home#index"
end
