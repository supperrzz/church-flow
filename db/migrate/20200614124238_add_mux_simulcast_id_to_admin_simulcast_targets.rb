class AddMuxSimulcastIdToAdminSimulcastTargets < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_simulcast_targets, :mux_simulcast_id, :string
  end
end
