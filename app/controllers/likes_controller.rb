class LikesController < ApplicationController

    def create
        like = Like.create(like_params)
            like.liked = true
            like.save

        render json: like.song_playlist.format
    end


    def create_dislike
        like = Like.create(like_params)
        like.liked = false
        like.save

        render json: like.song_playlist.format
    end

    private

    def like_params
        params.require(:like).permit(:song_playlist_id, :user_id, :liked)
    end


end
