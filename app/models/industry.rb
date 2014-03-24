class Industry < ActiveRecord::Base
  has_many :ind_requirements #, dependent: :destroy
  has_many :requirements, through: :ind_requirements
  has_many :ind_questions, dependent: :destroy
  has_many :questions, through: :ind_questions
  has_many :ind_users, dependent: :destroy
  has_many :users, through: :ind_users
  has_many :ind_user_questions, dependent: :destroy
  has_many :user_questions, through: :ind_user_questions
  has_many :ind_user_requirements, dependent: :destroy
  has_many :user_requirements, through: :ind_user_requirements
  attr_accessible :indName
  default_scope order('indName')
end
