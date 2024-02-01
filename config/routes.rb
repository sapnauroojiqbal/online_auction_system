Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  authenticate :user do
    resources :users, only: [:show, :index, :destroy]
    resources :auctions
    resources :auctions, except: [:index] do
      member do
        patch :approve
      end
    end
    resources :bids
    resources :products, except: [:index] do
      member do
        patch :change_status
      end
    end
  end

  resources :products, only: [:index]
  resources :auctions, only: [:index]

  resources :users do
    member do
      patch :change_user_role
      get :add_admin  # Use 'get' to show the form
      post :create_admin
    end
  end
end
