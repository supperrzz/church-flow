class AddDiscardedAtToAdminLiveStreamStats < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_live_stream_stats, :discarded_at, :datetime
    add_index :admin_live_stream_stats, :discarded_at
  end
end
