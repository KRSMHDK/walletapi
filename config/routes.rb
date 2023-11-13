Rails.application.routes.draw do
  root "home#index"
  resources :home
  get '/sign_out', to: 'home#sign_out'
  get '/get_balance', to: 'home#balance'
  get '/api_docs', to: 'home#api_docs'
  post '/deposit', to: 'home#deposit'
  post '/withdraw', to: 'home#withdraw'
  post '/sign_in', to: 'home#sign_in'
  post '/transfer', to: 'home#transfer'
  resources :entities

  namespace :api do
    namespace :v1 do
      resources :wallets, only: [] do
        collection do
          post 'deposit'
          post 'withdraw'
          post 'transfer'
          get 'balance'
          get 'transactions'
        end
      end
    end
  end
end
