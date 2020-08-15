class DropSimulcastTargetsFromAdminLiveStreams < ActiveRecord::Migration[6.0]
  def change
    remove_column :admin_live_streams, :simulcast_targets, :json, array: true
  end
end
