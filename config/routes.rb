Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  resources :questions, only: [:index, :new,:create,:destroy] do
    resources :answer, only: [:index]
  end  
end
