Rails.application.routes.draw do
  devise_for :users
  mount SwaggerUI, at: 'docs/api'
  mount API => 'api'

  namespace :admin do
    resources :stations
    resources :users
  end

  resources :drivers
  resources :races do
    resources :teams

    member do
      get 'overview'
      get 'settings'
    end
  end

  root to: 'races#current'
end
