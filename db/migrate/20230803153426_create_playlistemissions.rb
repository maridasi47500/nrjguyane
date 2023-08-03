class CreatePlaylistemissions < ActiveRecord::Migration[7.0]
  def change
    create_table :playlistemissions do |t|
      t.integer :playlist_id
      t.integer :emission_id

      t.timestamps
    end
  end
end
