class AppSetting < ActiveRecord::Base
  attr_accessible :showIndustry, :user_id
  belongs_to :user
end
