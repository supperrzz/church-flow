class CreateChurches < ActiveRecord::Migration[6.0]
  def change
    create_table :churches do |t|
      t.string :name
      t.text :address
      t.string :phone_number
      t.string :fb
      t.string :youtube
      t.string :instagram
      t.text :give_link
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
