class AddEmbedCodeToAdminLiveStreams < ActiveRecord::Migration[6.0]
  def up
    add_column :admin_live_streams, :embed_code, :string
    add_index :admin_live_streams, :embed_code

    # Generate for existing
    Admin::LiveStream.all.each do |live|
      live.create_embed_code
      live.save!
    end
  end

  def down
    remove_index :admin_live_streams, :embed_code
    remove_column :admin_live_streams, :embed_code, :string
  end
end
