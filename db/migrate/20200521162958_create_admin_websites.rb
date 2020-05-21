class CreateAdminWebsites < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_websites do |t|
      t.string :primary_color
      t.integer :heading_font
      t.integer :body_font
      t.string :youtube_live
      t.belongs_to :church, null: false, foreign_key: true

      t.timestamps
    end
  end
end
