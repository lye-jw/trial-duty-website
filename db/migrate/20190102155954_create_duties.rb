class CreateDuties < ActiveRecord::Migration[5.2]
  def change
    create_table :duties do |t|
      t.references :user, foreign_key: true
      t.references :timeslot, foreign_key: true
      t.date :date
      t.boolean :free
      t.references :request_user, index: true

      t.timestamps
    end
    add_foreign_key :duties, :users, column: :request_user_id
  end
end
