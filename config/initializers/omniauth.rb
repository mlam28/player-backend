 require 'rspotify/oauth'


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['client_id'], ENV['client_secret'], scope: 'user-read-email user-read-private playlist-modify-public user-library-read user-library-modify streaming app-remote-control user-read-playback-state user-modify-playback-state',  provider_ignores_state: true
end
