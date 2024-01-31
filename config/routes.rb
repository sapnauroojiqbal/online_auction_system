Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  authenticate :user do
    resources :auctions
    resources :bids
    resources :products
  end

  namespace :admin do
    resources :dashboard
  end

  namespace :buyer do
    resources :dashboard
  end

  namespace :seller do
    resources :dashboard
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
