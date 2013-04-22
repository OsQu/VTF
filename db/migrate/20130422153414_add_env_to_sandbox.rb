class AddEnvToSandbox < ActiveRecord::Migration
  def change
    add_column :sandboxes, :env, :string
  end
end
