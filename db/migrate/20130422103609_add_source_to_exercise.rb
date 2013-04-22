class AddSourceToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :sources, :string
  end
end
