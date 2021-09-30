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

  get '/workflows', to: 'workflows#search', as: :workflows

  resources :workflows, only: [:create, :show, :update, :destroy] do
    resources :tasks, only: [:index, :show]
    member do
      get :completion
    end
  end

  put '/activate', to: 'workflows#activate', as: :activate

  get '/tasks', to: 'tasks#search', as: :tasks

  resources :tasks, only: [:index, :new, :create, :destroy, :update] do
    resources :items, only: [:new]
    resources :task_members, only: [:create, :new]
    member do
      get :complete_task
      get :complete_mytask
      get :show_mytask
    end
    get :email_notification, to: "notifications#email_notification"
  end

  resources :items, only: [:index, :create, :show, :destroy] do
    member do
      patch :move
      patch :move_repo
    end
  end



end
