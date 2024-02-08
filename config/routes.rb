Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  authenticate :user do
    resources :users, only: [:show, :index, :destroy]
    resources :reviews, only: [:new, :create]
    resources :auctions do
      member do
        patch :change_status
        post :assign_products_to_auction
      end
    end

    resources :bids
    resources :products do
      member do
        patch :change_status
      end
    end
  end

  resources :users do
    member do
      patch :change_user_role
      get :add_admin
      post :create_admin
    end
  end

  match '*unmatched', to: 'application#not_found_method', via: :all
end
