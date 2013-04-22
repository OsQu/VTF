class CreateSourceCode < ActiveRecord::Migration
  def change
    create_table :source_codes do |t|
      t.text :body
      t.references :exercise

      t.timestamps
    end
  end
end
