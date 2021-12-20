Rails.application.routes.draw do
  
  devise_for :users
  root to: 'professionals#index'

  resources :professionals do
    resources :appointments
    collection do
      get 'export_appointments', action: 'export_appointments'
      post 'download_appointments', action: 'download_appointments'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
