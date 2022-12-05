Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  post 'create_account', to: 'home#create_account'
  
  resources :accounts, only: [] do
    post 'deposit', to: 'accounts#deposit', on: :member, as: 'deposit'
    post 'withdraw', to: 'accounts#withdraw', on: :member, as: 'withdraw'
    post 'transfer', to: 'accounts#transfer', on: :member, as: 'transfer'
  end
end

