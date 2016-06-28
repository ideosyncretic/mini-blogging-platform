Rails.application.routes.draw do

  root 'posts#index', as: 'home'
    # root 'users#index', as: 'home'

  resources :users do
    resources :posts
  end

  get 'sign_up', to: 'users#new', as: :sign_up

  get 'sign_in', to: 'sessions#new'
  delete 'sign_out', to: 'sessions#destroy'
  # add another route to lead to sessions
  resources :sessions, only:[:new, :create, :destroy]

  get 'new_user_post', to: 'posts#new'
  get 'edit_user_post', to: 'posts#edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
