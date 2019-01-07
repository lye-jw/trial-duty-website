class CreateProblemReports < ActiveRecord::Migration[5.2]
  def change
    create_table :problem_reports do |t|
      t.references :reporter_user
      t.references :place, foreign_key: true
      t.string :computer_number
      t.string :description
      t.boolean :is_critical
      t.boolean :is_fixed
      t.boolean :is_fixable
      t.boolean :is_blocked
      t.string :remarks
      t.references :last_update_user

      t.timestamps
    end
    add_foreign_key :problem_reports, :users, column: :reporter_user_id,
      primary_key: :id
    add_foreign_key :problem_reports, :users, column: :last_update_user_id,
      primary_key: :id
  end
end
