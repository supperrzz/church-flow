class CreateAdminMediaSermons < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_media_sermons do |t|
      t.string :title
      t.string :speaker
      t.string :scripture
      t.belongs_to :church, null: false, foreign_key: true

      t.timestamps
    end
  end
end
