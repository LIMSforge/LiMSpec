class IndUser < ActiveRecord::Base
   attr_accessible :industry_id, :user_id
   belongs_to :industry
   belongs_to :user

end
