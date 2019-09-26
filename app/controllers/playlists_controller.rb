class PlaylistsController < ApplicationController

    def create
        playlist = Playlist.create(playlist_params) 
        playlist_data = {name: playlist.name, id: playlist.id, uri: '', images: [], songs: []} 
        render json: playlist_data
    end


    private

    def playlist_params
        params.require(:playlist).permit(:name, :playlist_spotify_id, user_ids: [])
    end
end
