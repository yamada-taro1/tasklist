Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
    root to:'tasks#index'
    resources :tasks
    
    get 'signup', to: 'users#new'
    resources :users, only: [:index, :show, :create]
end
