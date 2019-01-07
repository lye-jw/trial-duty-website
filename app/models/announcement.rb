class Announcement < ApplicationRecord
  validates :subject, presence: true
  validates :details, presence: true
end
