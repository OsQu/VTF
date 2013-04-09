class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :category
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end