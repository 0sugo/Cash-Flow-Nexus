Rails.application.routes.draw do
  # get 'home', to: 'home#index', as: 'home'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :financial_groups do
  resources :financial_entities
  end
end
