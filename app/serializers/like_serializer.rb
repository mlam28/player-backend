class LikeSerializer < ActiveModel::Serializer
  attributes :id, :liked, :user_id, :song_playlist_id
end
