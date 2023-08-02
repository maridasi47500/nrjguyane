class CreateVideoplaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :videoplaylists do |t|

      t.timestamps
    end
        create_table :vidhasplaylists do |t|
t.integer :video
t.integer :videoplaylist_id
        end 
  end
end
