Rails.application.routes.draw do  
  root "home#index"

  namespace :api do
    namespace :v1 do
      resources :wallets, only: [] do
        collection do
          post 'deposit'
          post 'withdraw'
          get 'balance'
          get 'transactions'
        end
      end
    end
  end
end
