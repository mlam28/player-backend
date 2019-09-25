class AddArtistToSongPlaylists < ActiveRecord::Migration[5.2]
  def change
    add_column :song_playlists, :artist, :string
  end
end
