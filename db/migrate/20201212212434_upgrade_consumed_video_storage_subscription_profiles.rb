class UpgradeConsumedVideoStorageSubscriptionProfiles < ActiveRecord::Migration[6.0]
  def up
    change_column :subscription_profiles, :consumed_video_storage, :bigint
  end

  def down
    change_column :subscription_profiles, :consumed_video_storage, :integer
  end
end
