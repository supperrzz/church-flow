class ChangeColumnRoleDefaultInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :role, :integer, default: 1
  end
end
