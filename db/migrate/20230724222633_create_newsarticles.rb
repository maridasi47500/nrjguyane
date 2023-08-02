class CreateNewsarticles < ActiveRecord::Migration[7.0]
  def change
    create_table :newsarticles do |t|
      t.string :type
      t.string :title
      t.text :content
      t.string :image
      t.text :comphoto
      t.string :subtitle
      t.integer :user_id

      t.timestamps
    end
  end
end
