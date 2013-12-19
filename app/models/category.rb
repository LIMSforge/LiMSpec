class Category < ActiveRecord::Base

  attr_accessible :catName, :catAbbr
  has_many :requirements
  has_many :user_requirements
  default_scope order('catName')


end
