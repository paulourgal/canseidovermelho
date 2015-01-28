Rails.application.routes.draw do

  get "sign_up" => "users#new", :as => "sign_up"
  get "log_in" => "sessions#new", :as => "log_in"
  delete "log_out" => "sessions#destroy", :as => "log_out"

  resources :users
  resources :sessions

  get 'incomings/index'

  root :to => "incomings#index"

end
