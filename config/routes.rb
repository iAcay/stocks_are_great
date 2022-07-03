Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "welcome#index"
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
  get 'search_friend', to: 'friendships#search'

  resources :user_stocks, only: %i[create destroy]
  resources :friendships, only: %i[index create destroy]
  resources :users, only: %i[show]
end
