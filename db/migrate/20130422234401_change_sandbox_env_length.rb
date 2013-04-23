class ChangeSandboxEnvLength < ActiveRecord::Migration
  def up
    change_column :sandboxes, :env, :text
  end

  def down
  end
end
