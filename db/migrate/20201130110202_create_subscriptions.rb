class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.float :cost
      t.integer :targets
      t.integer :live_streams
      t.integer :video_storage
      t.integer :stream_size
      t.integer :viewer_count

      t.timestamps
    end
  end
end
