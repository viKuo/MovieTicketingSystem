Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'showtimes#index'
  resources :auditoria
  resources :movies
  resources :showtimes
  resources :tickets
  resources :admin, only: [:index]

end
