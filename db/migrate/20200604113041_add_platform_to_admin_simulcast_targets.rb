class AddPlatformToAdminSimulcastTargets < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_simulcast_targets, :platform, :string
  end
end
