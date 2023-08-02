class CreateMyanimateurs < ActiveRecord::Migration[7.0]
  def change
    create_table :animateurs do |t|
    t.string "title"
    t.string "type"
    t.string "image"
    t.text "description"
    t.boolean "link"
    t.text "subtitle"
      t.timestamps
    end
  end
end
