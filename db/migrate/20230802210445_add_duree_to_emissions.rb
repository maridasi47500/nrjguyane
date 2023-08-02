class AddDureeToEmissions < ActiveRecord::Migration[7.0]
  def change
      create_table "emissions" do |t|
    t.string "title"
    t.string "type"
    t.string "image"
    t.string "description"
    t.boolean "link"
        t.time :duree_emission
    t.time :heure_emission

    t.string "subtitle"
    t.timestamps
  end

  end
end
