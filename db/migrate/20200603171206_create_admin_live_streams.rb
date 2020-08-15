class CreateAdminLiveStreams < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_live_streams do |t|
      t.string :name
      t.string :playback_policy
      t.string :mux_stream_id
      t.string :mux_stream_key
      t.json :simulcast_targets, array: true, default: []
      t.belongs_to :church, null: false, foreign_key: true

      t.timestamps
    end
  end
end
