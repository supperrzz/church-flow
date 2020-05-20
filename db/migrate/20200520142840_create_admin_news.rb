class CreateAdminNews < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_news do |t|
      t.string :title
      t.text :body
      t.belongs_to :church

      t.timestamps
    end
  end
end
