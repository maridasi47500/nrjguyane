class CreateWeekdays < ActiveRecord::Migration[7.0]
  def change
    create_table :hasweekdays do |t|
      t.integer :emission_id
      t.integer :weekday_id
    end
    create_table :weekdays do |t|
      t.string :name

      t.timestamps
    end
  end
end
