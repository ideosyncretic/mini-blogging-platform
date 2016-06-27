Rails.application.routes.draw do

  root 'users#index'

  resources :users do
      resources :posts
  end

  get 'sign_in', to: 'sessions#new'
  delete 'sign_out', to: 'sessions#destroy'
  # add another route to lead to sessions
  resources :sessions, only:[:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end