class AddHlsUrlToAdminMediaSermons < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_media_sermons, :hls_url, :text
  end
end
