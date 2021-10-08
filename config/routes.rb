Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/users/upgrade-to-host', to: 'users#upgrade_to_host', as: 'upgrade_to_host'
  # resources :flats
  resources :flats do
    resources :bookings
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
