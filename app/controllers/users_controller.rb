class UsersController < ApplicationController

    def login
        query_params = {
            client_id: ENV['client_id'],
            response_type: "code",
            redirect_uri: "http://localhost:3000/auth/spotify/callback",
            scope: 'user-read-email user-read-private playlist-modify-private playlist-modify-public user-library-read user-library-modify streaming app-remote-control user-read-playback-state user-modify-playback-state',
            show_dialog: true
        }
        url = 'https://accounts.spotify.com/authorize'
        redirect_to "#{url}?#{query_params.to_query}"
      
    end

    def spotify
        spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
        
        user = User.find_by(spotify_id: spotify_user.id)
        if user === nil
            user = User.create(display_name: spotify_user.display_name, spotify_id: spotify_user.id, spotify_uri: spotify_user.uri, token: spotify_user.credentials.token, spotify_info: spotify_user.to_hash, image: spotify_user.images[0].url)
        else
            user.update(token: spotify_user.credentials.token, spotify_info: spotify_user.to_hash, image: spotify_user.images[0].url)
        end

        
    
        auth_params = {id: user.id, display_name: user.display_name, spotify_id: user.spotify_id, token: spotify_user.credentials.token, spotify_uri: user.spotify_uri}
        # render json: spotify_user.to_hash
        redirect_to 'http://localhost:3001/#' + auth_params.to_query
    end

    def index
        users = User.all 
        render json: users.to_json(user_serializer_options)
    end


    def show
        user = User.find(params[:id])

        formatted_playlists = user.user_playlists.map do |user_playlist|
            playlist = user_playlist.playlist
            {name: playlist.name, playlist_uri: user_playlist.playlist_spotify_id, id: playlist.id, uri: user_playlist.playlist_spotify_id, images:[], songs: SongPlaylist.format_with_likes(playlist.song_playlists)}
        end
        render json: formatted_playlists
    end

    def find_playlists
        user = User.find(params[:id])
    end


    def copyspotify
        user = User.find(user_spotify_params[:userId])
        spotify_user = RSpotify::User.new(user.spotify_info)
        user_playlist = UserPlaylist.find_by(user_id: user_spotify_params[:userId], playlist_id: user_spotify_params[:playlistId])
        
       new_playlist = spotify_user.create_playlist!(user_spotify_params[:name])
       new_playlist.add_tracks!(user_spotify_params[:tracks])
       new_uri = new_playlist.uri
       user_playlist.update(playlist_spotify_id: new_uri)
        render json: {spotify_playlist_uri: new_uri, message: 'successfully downloaded!'}
    end


    def updatespotify
        user = User.find(user_spotify_params[:userId])
        spotify_user = RSpotify::User.new(user.spotify_info)
        user_playlist = UserPlaylist.find_by(user_id: user_spotify_params[:userId], playlist_id: user_spotify_params[:playlistId])
        spot_play_id = user_playlist.playlist_spotify_id.split(':')[2]
        playlist = RSpotify::Playlist.find(user.spotify_id, spot_play_id)
        playlist.replace_tracks!([])
        playlist.add_tracks!(user_spotify_params[:tracks])
        render json: {message: 'successfully updated!'}
    end




    private


    def user_serializer_options
        {:include => {
            :playlists => {:include => {:users => {:except => [:created_at, :updated_at]},
                    :song_playlists => {:except => [:created_at, :updated_at]},
                    :user_playlists => {:except => [:created_at, :updated_at]}
                }
            }
        },
        :except => [:created_at, :updated_at]
    }
    end


    def song_serializer_options
        {
            :include => {
                :likes => {
                    :include => {:users =>{:except => [:created_at, :updated_at]}}
                }
            }
        }
    end

    def user_spotify_params
        params.permit(:userId, :name, :playlistId, tracks: [])
    end
end
