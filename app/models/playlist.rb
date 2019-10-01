class Playlist < ApplicationRecord
    has_many :user_playlists, dependent: :destroy
    has_many :users, through: :user_playlists
    has_many :song_playlists, dependent: :destroy
    has_many :back_logs
end
