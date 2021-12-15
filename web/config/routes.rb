Rails.application.routes.draw do
  
  devise_for :users
  root to: 'professionals#index'

  resources :professionals do
    resources :appointments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
