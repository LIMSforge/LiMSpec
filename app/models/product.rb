class Product < ActiveRecord::Base
  attr_accessible :description, :name, :vendor, :productClass, :headquarterLocation

  has_and_belongs_to_many :question_versions



end
