class AddVideoDataToAdminMediaSermons < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_media_sermons, :video_data, :text
  end
end
