class CreateAnimateurs < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :type
      t.string :image
      t.string :description
      t.boolean :link

      t.timestamps
    end
  end
end
