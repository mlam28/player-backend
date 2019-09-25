class PlaylistsController < ApplicationController

    def create
        byebug
    end


    private

    def playlist_params
        params.require(:playlist).permit(:name, :playlist_spotify_id, :user_ids: [])
    end
end
