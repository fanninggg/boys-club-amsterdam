Rails.application.routes.draw do
  devise_for :users
  root :to => "things#index"
  resources :things
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
