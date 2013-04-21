class AddSandboxes < ActiveRecord::Migration
  def change
    create_table :sandboxes do |t|
      t.references :user
      t.references :exercise
      t.timestamps
    end
  end
end
