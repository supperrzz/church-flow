class ChangeFontsFieldsInWebsites < ActiveRecord::Migration[6.0]
  def up
    change_column :admin_websites, :heading_font, :string
    change_column :admin_websites, :body_font, :string
  end

  def down
    change_column :admin_websites, :heading_font, :integer
    change_column :admin_websites, :body_font, :integer
  end
end
