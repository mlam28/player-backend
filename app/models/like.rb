class Like < ApplicationRecord
    belongs_to :user
    belongs_to :song_playlist
end
