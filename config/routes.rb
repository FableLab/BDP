Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  resources :users, only: [:new, :create]
  resource :sessions, only: [:new, :create, :destroy]
  resources :admin, only: [:index]
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :labels, only: [:index, :show, :edit, :update, :new, :create]
    resources :projets, only: [:index, :show, :edit, :update, :new, :create]
    resources :categories, only: [:index, :show, :edit, :update, :new, :create]
  end
end
