Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :articles do
    get 'list', on: :collection
  end

  root to: 'articles#index'
end
