class AddImagesDataToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :profile_picture_data, :text
    add_column :admin_events, :image_data, :text
    add_column :admin_news, :image_data, :text
    add_column :admin_media_images, :image_data, :text
    add_column :admin_websites, :hero_image_data, :text
    add_column :admin_members, :profile_picture_data, :text
  end
end
