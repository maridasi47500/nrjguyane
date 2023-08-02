class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :myid
      t.integer :videoplaylist_id

      t.timestamps
    end
  end
end
