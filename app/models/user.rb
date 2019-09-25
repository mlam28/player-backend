class User < ApplicationRecord
    has_many :user_playlists, dependent: :destroy
    has_many :playlists, through: :user_playlists, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :song_playlists, through: :likes
    accepts_nested_attributes_for :playlists
end
