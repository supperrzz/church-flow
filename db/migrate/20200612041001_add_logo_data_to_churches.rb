class AddLogoDataToChurches < ActiveRecord::Migration[6.0]
  def change
    add_column :churches, :logo_data, :text
  end
end
