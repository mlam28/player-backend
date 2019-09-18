class CreateSongPlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :song_playlists do |t|
      t.string :song_spotify_id
      t.integer :playlist_id

      t.timestamps
    end
  end
end
