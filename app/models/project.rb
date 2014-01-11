class Project < ActiveRecord::Base
  attr_accessible :projectName
  has_many :users, through: :project_users
  has_many :organizations, through: :project_organizations

end
