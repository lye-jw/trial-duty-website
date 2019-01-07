class Availability < ApplicationRecord
  belongs_to :user
  belongs_to :time_range
  enum day: Date::DAYNAMES
  validates :day, presence: true
end
