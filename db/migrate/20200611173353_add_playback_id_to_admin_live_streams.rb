class AddPlaybackIdToAdminLiveStreams < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_live_streams, :playback_id, :string
  end
end
