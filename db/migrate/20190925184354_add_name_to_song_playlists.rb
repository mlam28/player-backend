class AddNameToSongPlaylists < ActiveRecord::Migration[5.2]
  def change
    add_column :song_playlists, :name, :string
  end
end
