Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get '/dashboard', to: "dashboard#index", as: :dashboard
  get '/current', to: 'dashboard#my_tasks', as: :current

  resources :workflows, only: [:create, :show, :update] do
    resources :tasks, only: [:index, :show]
    member do
      get :completion
    end
  end

  put '/activate', to: 'workflows#activate', as: :activate

  resources :tasks, only: [:index, :new, :create, :destroy, :update] do
    resources :items, only: [:new]
    resources :task_members, only: [:create]
    member do
      get :completed
    end
  end
  get '/current/task', to: 'tasks#show_mytask'

  resources :task_members, only: [:new]

  resources :items, only: [:index, :create, :show, :destroy] do
    member do
      patch :move
    end
  end

end
