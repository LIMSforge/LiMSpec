class Organization < ActiveRecord::Base
  attr_accessible :orgName, :orgType
  has_many :responses
  has_many :users

end
