class AddHlsThumbnailUrlToAdminMediaSermons < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_media_sermons, :hls_thumbnail_url, :text
  end
end
