Todolist::Application.routes.draw do
  resources :todos,   only: [:index, :update, :create]
  resource  :session, only: [:destroy]

  match '/auth/google',             as: :login
  match '/auth/failure',            to: redirect('/')
  match '/auth/:provider/callback', to: 'sessions#create'

  root to: 'pages#welcome'
end
