class AddLocationToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_events, :location, :string
  end
end
