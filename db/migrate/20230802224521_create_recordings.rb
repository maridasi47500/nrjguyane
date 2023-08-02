class CreateRecordings < ActiveRecord::Migration[7.0]
  def change
    create_table :recordings do |t|
    t.string "title"
    t.string "artist"
    t.string "filename"
    t.float "duree"
      t.string "image"

      t.timestamps
    end
    create_table :playlistrecordings do |t|
      t.integer :recording_id
      t.integer :playlist_id
    end
  end
end
