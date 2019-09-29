class LikesController < ApplicationController

    def create
        
        like = Like.create(like_params)
        render json: like.song_playlist.format
    end

    private

    def like_params
        params.require(:like).permit(:song_playlist_id, :user_id)
    end


end
