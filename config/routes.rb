Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # OAuth2 callback
  get '/auth/:provider/callback', to: 'sessions#create'

  root to: 'home#show'

  resources :sessions, only: %i[new create]
  get 'sign_out', to: 'sessions#destroy'
end
