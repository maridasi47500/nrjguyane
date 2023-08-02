class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists do |t|
      t.integer :current_id
      t.datetime :heure_playlist
      t.timestamps
    end
  end
end
