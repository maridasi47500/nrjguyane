class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :playlistsongs do |t|
      t.integer :song_id
      t.string :playlist_id
      t.datetime :heure_chanson

    end
    create_table :songs do |t|
      t.string :title
      t.string :artist
      t.string :filename

      t.timestamps
    end
  end
end
