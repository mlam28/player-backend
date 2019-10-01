class CreateBackLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :back_logs do |t|
      t.integer :playlist_id
      t.integer :user_id
      t.text :action

      t.timestamps
    end
  end
end
