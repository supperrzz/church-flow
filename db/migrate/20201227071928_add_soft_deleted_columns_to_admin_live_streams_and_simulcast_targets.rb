class AddSoftDeletedColumnsToAdminLiveStreamsAndSimulcastTargets < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_live_streams, :discarded_at, :datetime
    add_index :admin_live_streams, :discarded_at

    add_column :admin_simulcast_targets, :discarded_at, :datetime
    add_index :admin_simulcast_targets, :discarded_at
  end
end
