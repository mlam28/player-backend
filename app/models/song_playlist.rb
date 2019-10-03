class SongPlaylist < ApplicationRecord
    belongs_to :playlist
    has_many :likes


    def self.format_with_likes(song_playlists)
        song_playlists.map do |song|
            {id: song.id, name: song.name, artist: song.artist, uri: song.uri, time: song.time, playlist_id: song.playlist_id, artist_uri: song.artist_uri, likes: song.likes.where(liked: true), dislikes: song.likes.where(liked: false)}
        end
    end

    def format
        {id: self.id, name: self.name, artist: self.artist, uri: self.uri, time: self.time, playlist_id: self.playlist_id, artist_uri: self.artist_uri, likes: self.likes.where(liked: true), dislikes: self.likes.where(liked: false)}
    end

end
