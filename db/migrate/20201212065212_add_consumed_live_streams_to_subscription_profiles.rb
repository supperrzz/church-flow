class AddConsumedLiveStreamsToSubscriptionProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :subscription_profiles, :consumed_live_streams, :integer, default: 0
    change_column :subscription_profiles, :consumed_stream_size, :integer, default: 0
    change_column :subscription_profiles, :consumed_targets, :integer, default: 0
    change_column :subscription_profiles, :consumed_video_storage, :integer, default: 0
    change_column :subscription_profiles, :consumed_viewer_count, :integer, default: 0
  end
end
