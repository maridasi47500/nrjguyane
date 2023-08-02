class AddJobToAnimateurs < ActiveRecord::Migration[7.0]
  def change
    add_column :animateurs, :job, :string
  end
end
