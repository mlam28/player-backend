class AddTimeToSongPlaylists < ActiveRecord::Migration[5.2]
  def change
    add_column :song_playlists, :time, :string
  end
end
