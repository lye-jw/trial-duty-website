class ChangeTimeslotDayTypeToInteger < ActiveRecord::Migration[5.2]
  def up
    # For postgres USING CAST needed to change string to integer
    change_column :timeslots, :day,'integer USING CAST(day AS integer)'
  end

  def down
    change_column :timeslots, :day, 'text USING CAST(day AS text)'
  end
end