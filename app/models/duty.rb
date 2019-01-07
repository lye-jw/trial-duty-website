class Duty < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :timeslot
  belongs_to :request_user, class_name: 'User', optional: true,
                            inverse_of: :duties
  has_one :time_range, through: :timeslot
  has_one :place, through: :timeslot

  validates :date, uniqueness: { scope: :timeslot_id }
  scope :ordered_by_start_time,
        -> { joins(:time_range).order('time_ranges.start_time') }

  def self.generate(start_date, end_date)
    (start_date..end_date).each do |date|
      day = Date::DAYNAMES[date.wday]
      Timeslot.where(day: day).find_each do |ts|
        duty = Duty.find_or_create_by(timeslot: ts, date: date)
        duty.user = ts.default_user
        duty.save
      end
    end
  end
end
