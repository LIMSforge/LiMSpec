class Role < ActiveRecord::Base
  attr_accessible :roleName
  has_many :role_assignments
  has_many :users, through: :role_assignments
end
