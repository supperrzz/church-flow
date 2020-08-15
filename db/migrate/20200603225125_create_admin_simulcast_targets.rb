class CreateAdminSimulcastTargets < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_simulcast_targets do |t|
      t.string :stream_key
      t.string :url
      t.belongs_to :admin_live_stream, null: false, foreign_key: true

      t.timestamps
    end
  end
end
