class User < ApplicationRecord
  
  CELLS = %i[marketing presidential publicity technical training welfare]
          .freeze
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :cell, presence: true
  validates :email, presence: true

  enum cell: CELLS

  has_many :timeslots, foreign_key: :default_user_id,
                       inverse_of: :default_user,
                       dependent: :nullify
  has_many :duties, dependent: :nullify
  has_many :availabilities, dependent: :destroy

  has_many :reported_problem_reports, class_name: 'ProblemReport',
                                      foreign_key: 'reporter_user_id',
                                      inverse_of: :reporter_user,
                                      dependent: :nullify
  has_many :last_updated_problem_reports, class_name: 'ProblemReport',
                                          foreign_key: 'last_update_user_id',
                                          inverse_of: :last_update_user,
                                          dependent: :nullify

end