class SongPlaylistSerializer < ActiveModel::Serializer
  attributes :id, :song_spotify_id, :playlist_id
end
