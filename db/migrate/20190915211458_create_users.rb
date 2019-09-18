class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :display_name
      t.string :spotify_id
      t.string :spotify_uri
      t.timestamps
    end
  end
end
