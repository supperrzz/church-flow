class CreateLivestreamStats < ActiveRecord::Migration[6.0]
  def change
    create_table :livestream_stats do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.jsonb :data
      t.string :status

      t.timestamps
    end
  end
end
