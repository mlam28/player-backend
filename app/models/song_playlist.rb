class SongPlaylist < ApplicationRecord
    belongs_to :playlist
    has_many :likes


    def self.format_with_likes(song_playlists)
        song_playlists.map do |song|
            {name: song.name, artist: song.artist, uri: song.uri, time: song.time, playlist_id: song.playlist_id, artist_uri: song.artist_uri, likes: song.likes}
        end
    end

end
