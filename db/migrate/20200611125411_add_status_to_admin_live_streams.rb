class AddStatusToAdminLiveStreams < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_live_streams, :status, :string
  end
end
