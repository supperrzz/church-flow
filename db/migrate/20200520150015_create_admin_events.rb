class CreateAdminEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_events do |t|
      t.string :name
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.text :address
      t.text :description
      t.string :link
      t.belongs_to :church

      t.timestamps
    end
  end
end
