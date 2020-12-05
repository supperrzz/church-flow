class CreateSubscriptionProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :subscription_profiles do |t|
      t.belongs_to :subscription, null: true, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.string :stripe_customer_id
      t.string :stripe_card_id
      t.string :stripe_subscription_id
      t.integer :consumed_stream_size
      t.integer :consumed_targets
      t.integer :consumed_video_storage
      t.integer :consumed_viewer_count
      t.boolean :active

      t.timestamps
    end
  end
end
