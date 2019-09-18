class CreateUserPlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :user_playlists do |t|
      t.string :playlist_spotify_id
      t.integer :playlist_id
      t.integer :user_id

      t.timestamps
    end
  end
end
