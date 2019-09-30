class UserPlaylistsController < ApplicationController

    def create
        byebug
        other_user = User.find_by(spotify_uri: up_params[:add_uri])
        byebug
        if other_user == nil 
            render json: {message: 'user must first create an account with app'}
        else 
        user_playlist = UserPlaylist.find_by(user_id: other_user.id, playlist_id: up_params[:playlist_id])
            if user_playlist.nil?
                byebug
            user_playlist = UserPlaylist.create(user_id: other_user.id, playlist_id: up_params[:playlist_id])
            render json: {message: 'user added to this playlist'}
            else
                byebug
            render json: {message: 'user is already added to this playlist'}
            end
        end

    end




    private

    def up_params
        params.require(:user_playlist).permit(:user_id, :playlist_id, :add_uri)
    end
end
