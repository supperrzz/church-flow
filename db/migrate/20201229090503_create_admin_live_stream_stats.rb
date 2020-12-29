class CreateAdminLiveStreamStats < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_live_stream_stats do |t|
      t.belongs_to :admin_live_stream, null: false, foreign_key: true
      t.string :asset_id
      t.float :asset_duration
      t.float :delivered_seconds
      t.datetime :asset_created_at

      t.timestamps
    end
  end
end
