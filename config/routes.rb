Rails.application.routes.draw do
  resources :attractions
  get '/signin', to: 'sessions#new'
  post '/signin', to: "sessions#create"
  get '/logout', to: 'sessions#destroy'
  post '/attractions/:id/takeride', to: 'attractions#takeride', as: 'takeride'
  resources :users, only: [:new,:show,:create]

  root to: 'static#home' 
end
