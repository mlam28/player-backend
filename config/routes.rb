Rails.application.routes.draw do
  resources :back_logs
  get '/auth/spotify/callback', to: 'users#spotify'
  resources :users
  resources :likes
  post '/dislikes', to: 'likes#create_dislike'
  resources :song_playlists
  resources :playlists, except: [:show]
  get '/playlists/:id/:user_id', to: 'playlists#show'
  resources :user_playlists
  get '/login', to: 'users#login'
  post '/copytospotify', to: 'users#copyspotify'
  put '/updatespotify', to: 'users#updatespotify'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
