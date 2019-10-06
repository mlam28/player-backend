class UserPlaylistsController < ApplicationController

    def create

        other_user = User.find_by(spotify_uri: up_params[:add_uri])

        if other_user.nil?

            render json: {message: 'user must first create an account with app'}
        else 
        user_playlist = UserPlaylist.find_by(user_id: other_user.id, playlist_id: up_params[:playlist_id])
            if user_playlist.nil?

            user_playlist = UserPlaylist.create(user_id: other_user.id, playlist_id: up_params[:playlist_id])
            render json: {user: {name: other_user.display_name, spotify_uri: other_user.spotify_uri}, message: 'user added to this playlist'}
            else

            render json: {message: 'user is already added to this playlist'}
            end
        end

    end




    private

    def up_params
        params.require(:user_playlist).permit(:user_id, :playlist_id, :add_uri)
    end
end
