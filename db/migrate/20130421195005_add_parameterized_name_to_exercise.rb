class AddParameterizedNameToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :parameterized_name, :string, null: false
  end
end
