class CreateAdminMediaImages < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_media_images do |t|
      t.string :caption
      t.belongs_to :church, null: false, foreign_key: true

      t.timestamps
    end
  end
end
