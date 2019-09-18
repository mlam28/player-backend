class UserPlaylistSerializer < ActiveModel::Serializer
  attributes :id, :playlist_spotify_id, :playlist_id, :user_id
end
