Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  resources :users, only: [:index,:show]
  resources :questions, only: [:index, :new,:create,:destroy] do
    resources :answers, only: [:index,:create,:destroy] do
      resource :likes, only: [:create, :destroy]
    end  
  end  
end
