class BackLogSerializer < ActiveModel::Serializer
  attributes :id, :playlist_id, :user_id, :action
end
