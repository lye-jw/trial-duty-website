class CreateAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :announcements do |t|
      t.timestamp :date
      t.text :subject
      t.text :details

      t.timestamps
    end
  end
end
