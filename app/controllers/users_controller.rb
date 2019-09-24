class UsersController < ApplicationController

    def login
        query_params = {
            client_id: ENV['client_id'],
            response_type: "code",
            redirect_uri: "http://localhost:3000/auth/spotify/callback",
            scope: 'user-read-email user-read-private playlist-modify-public user-library-read user-library-modify streaming app-remote-control user-read-playback-state user-modify-playback-state',
            show_dialog: true
        }
        url = 'https://accounts.spotify.com/authorize'
        redirect_to "#{url}?#{query_params.to_query}"
      
    end

    def spotify
        spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
        user = User.find_by(spotify_id: spotify_user.id)
        if user === nil
            user = User.create(display_name: spotify_user.display_name, spotify_id: spotify_user.id, spotify_uri: spotify_user.uri, token: spotify_user.credentials.token)
        else
            user.update(token: spotify_user.credentials.token)
        end
    
        auth_params = {id: user.id, display_name: user.display_name, spotify_id: user.spotify_id, token: spotify_user.credentials.token, spotify_uri: user.spotify_uri}
        # render json: spotify_user.to_hash
        redirect_to 'http://localhost:3001/#' + auth_params.to_query
    end

    def index
        users = User.all 
        render json: users.to_json(user_serializer_options)
    end



    private


    def user_serializer_options
        {:include => {
            :playlists => {:include => {:users => {:except => [:created_at, :updated_at]},
                    :song_playlists => {:except => [:created_at, :updated_at]}
                }
            }
        },
        :except => [:created_at, :updated_at]
    }
    end

end
