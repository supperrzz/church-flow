class AddThumbnailDataToAdminMediaSermons < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_media_sermons, :thumbnail_data, :text
  end
end
