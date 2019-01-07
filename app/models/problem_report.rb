class ProblemReport < ApplicationRecord
  validates :computer_number, presence: true
  validates :description, presence: true

  belongs_to :reporter_user, class_name: 'User', optional: true,
                             inverse_of: :reported_problem_reports
  belongs_to :last_update_user, class_name: 'User', optional: true,
                                inverse_of: :last_updated_problem_reports
  belongs_to :place
end
