class AddArtistUriToSongPlaylists < ActiveRecord::Migration[5.2]
  def change
    add_column :song_playlists, :artist_uri, :string
  end
end
