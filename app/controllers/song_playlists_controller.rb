class SongPlaylistsController < ApplicationController

    def index
        render json: SongPlaylist.all
    end

    def create
        song = SongPlaylist.create(song_params)
        render json: {playlist_id: song.playlist.id, song: song.format}
    end
    
    def destroy
        song = SongPlaylist.find(params[:id])
        id = song.id
        playlistId = song.playlist_id
        song.destroy

        render json: {message: 'successfully deleted', songId: id, playlistId: playlistId}
    end

    private

    def song_params
        params.require(:song_playlist).permit(:name, :uri, :time, :artist_uri, :playlist_id, :artist)
    end
end
