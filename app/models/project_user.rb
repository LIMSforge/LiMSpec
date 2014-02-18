class ProjectUser < ActiveRecord::Base
  attr_accessible :user_id, :project_id

  has_many :users
  has_many :projects
end