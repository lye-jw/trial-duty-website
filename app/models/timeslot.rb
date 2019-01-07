class Timeslot < ApplicationRecord
  belongs_to :default_user, class_name: 'User', optional: true,
                            inverse_of: :timeslots
  belongs_to :time_range
  belongs_to :place
  has_many :duties, dependent: :destroy
  enum day: Date::DAYNAMES
end
