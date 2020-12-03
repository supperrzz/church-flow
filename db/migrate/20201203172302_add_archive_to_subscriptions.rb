class AddArchiveToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :active, :boolean, default: false
  end
end
