Rails.application.routes.draw do
  root to: "sessions#welcome"
  patch '/games/:id/join' => 'games#join', as: 'join_game'
  patch '/games/:id/leave' => 'games#leave', as: 'leave_game'
  patch '/games/:id/start' => 'games#start', as: 'start_game'
  post '/games/:game_id/words/:guess' => 'words#guess', as: 'guess_word'
  post '/games/:game_id/words' => 'words#guess'

  resources :users
  resources :games



  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
