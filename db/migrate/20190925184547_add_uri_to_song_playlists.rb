class AddUriToSongPlaylists < ActiveRecord::Migration[5.2]
  def change
    add_column :song_playlists, :uri, :string
  end
end
