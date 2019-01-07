class CreateAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities do |t|
      t.references :user, foreign_key: true
      t.integer :day, null: false
      t.references :time_range, foreign_key: true
      t.boolean :status, null: false
      t.index [:user_id, :day, :time_range_id], unique: true

      t.timestamps
    end
  end
end
