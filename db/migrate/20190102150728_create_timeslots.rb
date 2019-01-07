class CreateTimeslots < ActiveRecord::Migration[5.2]
  def change
    create_table :timeslots do |t|
      t.boolean :mc_only
      t.text :day
      t.references :default_user, index: true
      t.references :time_range, foreign_key: true
      t.references :place, foreign_key: true

      t.timestamps
    end
    add_foreign_key :timeslots, :users, column: :default_user_id
  end
end
