class ProductClass < ActiveRecord::Base
  attr_accessible :className

  default_scope order('className ASC')
end
