class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :matric_num
      t.string :contact_num
      t.integer :cell
      t.boolean :mc

      t.timestamps
    end
  end
end
