Rails.application.routes.draw do
  get 'sports/index'
  get 'sports/create'
  get 'sports/edit'
  get 'sports/update'
  get 'users/show'
  devise_for :users
  root to: 'homes#top'
  get '/about' => 'homes#about'
  resources :teams
  resources :users
  resources :sports
end
