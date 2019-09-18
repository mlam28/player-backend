class UsersController < ApplicationController

    def login
        query_params = {
            client_id: ENV['client_id'],
            response_type: "code",
            redirect_uri: "http://localhost:3000/auth/spotify/callback",
            scope: 'user-read-email playlist-modify-public user-library-read user-library-modify',
            show_dialog: true
        }
        url = 'https://accounts.spotify.com/authorize'
        redirect_to "#{url}?#{query_params.to_query}"
        # redirect_to '/auth/spotify'
    end

    def spotify
        spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
        user = User.find_by(spotify_id: spotify_user.id)
        if user === nil
        user = User.create(display_name: spotify_user.display_name, spotify_id: spotify_user.id, spotify_uri: spotify_user.uri)
        end
    
        auth_params = {id: user.id, display_name: user.display_name, spotify_id: user.spotify_id, access_token: spotify_user.credentials.token, spotify_uri: user.spotify_uri}
        # render json: spotify_user.to_hash
        redirect_to 'http://localhost:3001/#' + auth_params.to_query
    end

    private

end
