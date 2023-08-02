class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :posthavephotos do |t|
      t.integer :photo_id
      t.string :newsarticle_id
    end
    create_table :photos do |t|
      t.string :filename
      t.string :title

      t.timestamps
    end
  end
end
