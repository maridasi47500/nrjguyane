class CreateEmissionhasanimateurs < ActiveRecord::Migration[7.0]
  def change
    create_table :emissionhasanimateurs do |t|
      t.integer :emission_id
      t.integer :animateur_id

      t.timestamps
    end
  end
end
