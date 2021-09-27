Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  get '/dashboard', to: "dashboard#index", as: :dashboard

  resources :workflows, only: [:create, :show, :update] do
    resources :tasks, only: [:index, :show]
  end
  put '/activate', to: 'workflows#activate', as: :activate

  resources :tasks, only: [:index, :new, :create] do
    resources :items, only: [:new]

  end
  resources :items, only: [:index, :create, :show, :destroy] do
    member do
      patch :move
    end
  end
end
