class CreateSourceCode < ActiveRecord::Migration
  def change
    create_table :sourcecodes do |t|
      t.text :body
      t.references :exercise

      t.timestamps
    end
  end
end
